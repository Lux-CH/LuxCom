struct Itinerary: Codable {
    let duration: Int
    let startTime: Date
    let endTime: Date
    let transfers: Int
    let legs: [Leg]
}
