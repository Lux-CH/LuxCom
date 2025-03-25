//
//  Trip.swift
//  LuxCom
//
//  Created by Constantin Clerc on 12.03.2025.
//

import Foundation

struct Itinerary: Codable {
    let duration: Int
    let startTime: Date
    let endTime: Date
    let transfersNumber: Int
    
}
