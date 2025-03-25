//
//  Mode.swift
//  LuxCom
//
//  Created by Constantin Clerc on 12.03.2025.
//

public enum TransportationMode: String, Codable, Hashable {
    case walk = "WALK"
    case bike = "BIKE"
    case rental = "RENTAL"
    case car = "CAR"
    case carParking = "CAR_PARKING"
    case odm = "ODM"
    case transit = "TRANSIT"
    case tram = "TRAM"
    case subway = "SUBWAY"
    case ferry = "FERRY"
    case airplane = "AIRPLANE"
    case metro = "METRO"
    case bus = "BUS"
    case coach = "COACH"
    case rail = "RAIL"
    case highSpeedRail = "HIGHSPEED_RAIL"
    case longDistance = "LONG_DISTANCE"
    case nightRail = "NIGHT_RAIL"
    case regionalFastRail = "REGIONAL_FAST_RAIL"
    case regionalRail = "REGIONAL_RAIL"
    case other = "OTHER"
}
