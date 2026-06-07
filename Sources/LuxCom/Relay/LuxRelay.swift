import Foundation

public final class LuxRelay: @unchecked Sendable {
    public static let shared = LuxRelay()

    private let url = URL(string: "wss://lux.cclerc.ch/ws")!
    private let queue = DispatchQueue(label: "ch.cclerc.luxrelay")

    private var task: URLSessionWebSocketTask?
    private var continuations: [String: [(UUID, AsyncStream<StopTimes>.Continuation)]] = [:]
    private var subParams: [String: SubParams] = [:]
    private var reconnectDelay: TimeInterval = 1
    private var isConnecting = false

    private struct SubParams {
        let n: Int
        let radius: Int?
        let mode: [String]?
    }

    private init() {}

    public func subscribe(
        stopId: String,
        n: Int = 50,
        radius: Int? = 200,
        mode: [String]? = ["TRANSIT"]
    ) -> AsyncStream<StopTimes> {
        let id = UUID()
        return AsyncStream { continuation in
            self.queue.async {
                var list = self.continuations[stopId] ?? []
                let isFirst = list.isEmpty
                list.append((id, continuation))
                self.continuations[stopId] = list
                self.subParams[stopId] = SubParams(n: n, radius: radius, mode: mode)

                self.ensureConnected()

                if isFirst || self.task != nil {
                    self.sendSub(stopId: stopId, n: n, radius: radius, mode: mode)
                }
            }

            continuation.onTermination = { @Sendable _ in
                self.queue.async {
                    self.continuations[stopId]?.removeAll { $0.0 == id }
                    if self.continuations[stopId]?.isEmpty == true {
                        self.continuations.removeValue(forKey: stopId)
                        self.subParams.removeValue(forKey: stopId)
                        self.sendUnsub(stopId: stopId)
                    }

                    if self.continuations.isEmpty {
                        self.task?.cancel(with: .normalClosure, reason: nil)
                        self.task = nil
                    }
                }
            }
        }
    }

    // MARK: - Connection

    private func ensureConnected() {
        if task != nil || isConnecting { return }
        connect()
    }

    private func connect() {
        isConnecting = true
        let config = URLSessionConfiguration.default
        config.waitsForConnectivity = true
        let session = URLSession(configuration: config)
        let ws = session.webSocketTask(with: url)
        ws.resume()
        task = ws
        isConnecting = false
        reconnectDelay = 1

        for (stopId, p) in subParams {
            sendSub(stopId: stopId, n: p.n, radius: p.radius, mode: p.mode)
        }

        receiveLoop()
    }

    private func receiveLoop() {
        guard let ws = task else { return }

        ws.receive { [weak self] result in
            guard let self else { return }

            switch result {
            case .success(let message):
                if case .string(let text) = message {
                    self.handleMessage(text)
                }
                self.receiveLoop()

            case .failure:
                self.handleDisconnect()
            }
        }
    }

    // MARK: - Message handling

    private struct RelayMessage: Decodable {
        let ch: String
        let stopId: String?
        let data: StopTimes?
    }

    private func handleMessage(_ text: String) {
        guard let data = text.data(using: .utf8) else { return }

        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601

        guard let msg = try? decoder.decode(RelayMessage.self, from: data),
              msg.ch == "dep",
              let stopId = msg.stopId,
              let stopTimes = msg.data else { return }

        queue.async {
            guard let list = self.continuations[stopId] else { return }
            for (_, continuation) in list {
                continuation.yield(stopTimes)
            }
        }
    }

    // MARK: - Reconnect

    private func handleDisconnect() {
        queue.async {
            self.task?.cancel(with: .abnormalClosure, reason: nil)
            self.task = nil

            guard !self.continuations.isEmpty else { return }

            let delay = self.reconnectDelay
            self.reconnectDelay = min(self.reconnectDelay * 2, 30)

            Task { [weak self] in
                try? await Task.sleep(nanoseconds: UInt64(delay * 1_000_000_000))
                guard let self else { return }
                self.queue.async { [weak self] in
                    guard let self, self.task == nil, !self.continuations.isEmpty else { return }
                    self.connect()
                }
            }
        }
    }

    // MARK: - Send

    private func send(_ dict: [String: Any]) {
        guard let data = try? JSONSerialization.data(withJSONObject: dict),
              let text = String(data: data, encoding: .utf8) else { return }
        task?.send(.string(text)) { _ in }
    }

    private func sendSub(stopId: String, n: Int, radius: Int?, mode: [String]?) {
        var msg: [String: Any] = ["action": "sub", "stopId": stopId, "n": n]
        if let r = radius { msg["radius"] = r }
        if let m = mode { msg["mode"] = m }
        send(msg)
    }

    private func sendUnsub(stopId: String) {
        send(["action": "unsub", "stopId": stopId])
    }
}
