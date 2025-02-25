//
//  LuxCom.swift
//  LuxCom
//
//  Created by Constantin Clerc on 05.02.2025.
//

import OJP
import Foundation

public struct LuxComAPI {
    var apiKey: String
    
    public init(apiKey: String) {
        self.apiKey = apiKey
    }
    
    public func setup() -> OJP {
        let apiConf =  APIConfiguration(
            apiEndPoint: URL(string: "https://api.opentransportdata.swiss/ojp20")!,
            requesterReference: "Lux_Tests",
            additionalHeaders: [
                "Authorization": "Bearer \(apiKey)"
            ]
        )
        return OJP(
            loadingStrategy: .http(apiConf),
            language: Locale.current.language.languageCode?.identifier ?? "fr"
        )
    }
}
