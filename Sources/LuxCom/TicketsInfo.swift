//
//  TicketsInfo.swift
//  LuxCom
//
//  Created by Constantin Clerc on 03.06.2025.
//

import SwiftUI

public enum TicketCategory: String, CaseIterable, Hashable, Sendable {
    case toutGeneve = "Tout Genève"
    case frenchZoneTickets = "Billets zones françaises"
    case lemanPassMultizone = "Léman Pass Multizone"
    case complementaryTickets = "Billets complémentaires"
    case toutGeneveDayPass = "Pass journalier Tout Genève"
}

public enum UserType: String, CaseIterable, Hashable, Sendable {
    case adulte = "Adulte"
    case jeune = "Jeune"
    case ais = "AVS/AI"
}

public struct TicketInfo: Hashable, Sendable {
    public var title: String
    public var duration: Duration
    public var smsCode: String
    public var priceCHF: Double
    public var priceEUR: Double
    public var category: TicketCategory
    public var userType: UserType
}

public struct TicketsInfo {
    public var tickets = [
        // Tout Genève Zone 10 Tickets
        TicketInfo(title: "Tout Genève", duration: .seconds(3600), smsCode: "tpg1", priceCHF: 3.00, priceEUR: 3.30, category: .toutGeneve, userType: .adulte),
        TicketInfo(title: "Tout Genève 1/2 (tarif réduit)", duration: .seconds(3600), smsCode: "tpg2", priceCHF: 2.00, priceEUR: 2.20, category: .toutGeneve, userType: .jeune),
        TicketInfo(title: "Tout Genève AVS/AI", duration: .seconds(3600), smsCode: "tpg3", priceCHF: 2.00, priceEUR: 2.20, category: .toutGeneve, userType: .ais),
        
        // Pass journalier Tout Genève, Zone 10
        TicketInfo(title: "Pass journalier Tout Genève", duration: .seconds(86400), smsCode: "cj1", priceCHF: 10.00, priceEUR: 11.00, category: .toutGeneveDayPass, userType: .adulte),
        TicketInfo(title: "Pass journalier Tout Genève 1/2 (enfants 6-15 ans)", duration: .seconds(86400), smsCode: "cj2", priceCHF: 7.30, priceEUR: 8.10, category: .toutGeneveDayPass, userType: .jeune),
        TicketInfo(title: "Pass journalier Tout Genève AVS/AI", duration: .seconds(86400), smsCode: "cj3", priceCHF: 7.30, priceEUR: 8.10, category: .toutGeneveDayPass, userType: .ais),
        TicketInfo(title: "Pass journalier Tout Genève dès 9h00", duration: .seconds(54000), smsCode: "cj91", priceCHF: 8.00, priceEUR: 8.80, category: .toutGeneveDayPass, userType: .adulte),
        TicketInfo(title: "Pass journalier Tout Genève dès 9h00 1/2 (enfants 6-15 ans)", duration: .seconds(54000), smsCode: "cj92", priceCHF: 5.60, priceEUR: 6.20, category: .toutGeneveDayPass, userType: .jeune),
        TicketInfo(title: "Pass journalier Tout Genève dès 9h00 AVS/AI", duration: .seconds(54000), smsCode: "cj93", priceCHF: 5.60, priceEUR: 6.20, category: .toutGeneveDayPass, userType: .ais),
        
        // Léman Pass Multizone Tickets
        TicketInfo(title: "Billet multizone Zone 10+200", duration: .seconds(5400), smsCode: "10200", priceCHF: 4.60, priceEUR: 4.70, category: .lemanPassMultizone, userType: .adulte),
        TicketInfo(title: "Billet multizone Zone 10+200 (jeune)", duration: .seconds(5400), smsCode: "10200r", priceCHF: 3.30, priceEUR: 3.40, category: .lemanPassMultizone, userType: .jeune),
        TicketInfo(title: "Billet multizone Zone 10+210", duration: .seconds(5400), smsCode: "10210", priceCHF: 4.70, priceEUR: 4.80, category: .lemanPassMultizone, userType: .adulte),
        TicketInfo(title: "Billet multizone Zone 10+210 (jeune)", duration: .seconds(5400), smsCode: "10210r", priceCHF: 3.70, priceEUR: 3.80, category: .lemanPassMultizone, userType: .jeune),
        TicketInfo(title: "Billet multizone Zone 10+230", duration: .seconds(5400), smsCode: "10230", priceCHF: 4.60, priceEUR: 4.70, category: .lemanPassMultizone, userType: .adulte),
        TicketInfo(title: "Billet multizone Zone 10+230 (jeune)", duration: .seconds(5400), smsCode: "10230r", priceCHF: 3.30, priceEUR: 3.40, category: .lemanPassMultizone, userType: .jeune),
        TicketInfo(title: "Billet multizone Zone 10+240", duration: .seconds(5400), smsCode: "10240", priceCHF: 4.60, priceEUR: 4.70, category: .lemanPassMultizone, userType: .adulte),
        TicketInfo(title: "Billet multizone Zone 10+240 (jeune)", duration: .seconds(5400), smsCode: "10240r", priceCHF: 3.30, priceEUR: 3.40, category: .lemanPassMultizone, userType: .jeune),
        TicketInfo(title: "Billet multizone Zone 10+250", duration: .seconds(5400), smsCode: "10250", priceCHF: 4.60, priceEUR: 4.70, category: .lemanPassMultizone, userType: .adulte),
        TicketInfo(title: "Billet multizone Zone 10+250 (jeune)", duration: .seconds(5400), smsCode: "10250r", priceCHF: 3.30, priceEUR: 3.40, category: .lemanPassMultizone, userType: .jeune),
        
        // Billets complémentaires
        TicketInfo(title: "Billet complémentaire Zone 10", duration: .seconds(5400), smsCode: "c10", priceCHF: 3.00, priceEUR: 3.10, category: .complementaryTickets, userType: .adulte),
        TicketInfo(title: "Billet complémentaire Zone 10 (jeune)", duration: .seconds(5400), smsCode: "c10r", priceCHF: 2.00, priceEUR: 2.10, category: .complementaryTickets, userType: .jeune),
        TicketInfo(title: "Billet complémentaire Zone 200", duration: .seconds(5400), smsCode: "c200", priceCHF: 1.60, priceEUR: 1.60, category: .complementaryTickets, userType: .adulte),
        TicketInfo(title: "Billet complémentaire Zone 200 (jeune)", duration: .seconds(5400), smsCode: "c200r", priceCHF: 1.30, priceEUR: 1.30, category: .complementaryTickets, userType: .jeune),
        TicketInfo(title: "Billet complémentaire Zone 210", duration: .seconds(5400), smsCode: "c210", priceCHF: 1.70, priceEUR: 1.70, category: .complementaryTickets, userType: .adulte),
        TicketInfo(title: "Billet complémentaire Zone 210 (jeune)", duration: .seconds(5400), smsCode: "c210r", priceCHF: 1.70, priceEUR: 1.70, category: .complementaryTickets, userType: .jeune),
        TicketInfo(title: "Billet complémentaire Zone 230", duration: .seconds(5400), smsCode: "c230", priceCHF: 1.60, priceEUR: 1.60, category: .complementaryTickets, userType: .adulte),
        TicketInfo(title: "Billet complémentaire Zone 230 (jeune)", duration: .seconds(5400), smsCode: "c230r", priceCHF: 1.30, priceEUR: 1.30, category: .complementaryTickets, userType: .jeune),
        TicketInfo(title: "Billet complémentaire Zone 240", duration: .seconds(5400), smsCode: "c240", priceCHF: 1.60, priceEUR: 1.60, category: .complementaryTickets, userType: .adulte),
        TicketInfo(title: "Billet complémentaire Zone 240 (jeune)", duration: .seconds(5400), smsCode: "c240r", priceCHF: 1.30, priceEUR: 1.30, category: .complementaryTickets, userType: .jeune),
        TicketInfo(title: "Billet complémentaire Zone 250", duration: .seconds(5400), smsCode: "c250", priceCHF: 1.60, priceEUR: 1.60, category: .complementaryTickets, userType: .adulte),
        TicketInfo(title: "Billet complémentaire Zone 250 (jeune)", duration: .seconds(5400), smsCode: "c250r", priceCHF: 1.30, priceEUR: 1.30, category: .complementaryTickets, userType: .jeune),
        
        // Billets zones françaises
        TicketInfo(title: "Billet local Zone 200", duration: .seconds(3600), smsCode: "200", priceCHF: 1.60, priceEUR: 1.60, category: .frenchZoneTickets, userType: .adulte),
        TicketInfo(title: "Billet local Zone 200 (jeune)", duration: .seconds(3600), smsCode: "200r", priceCHF: 1.30, priceEUR: 1.30, category: .frenchZoneTickets, userType: .jeune),
        TicketInfo(title: "Billet local Zone 230", duration: .seconds(3600), smsCode: "230", priceCHF: 1.60, priceEUR: 1.60, category: .frenchZoneTickets, userType: .adulte),
        TicketInfo(title: "Billet local Zone 230 (jeune)", duration: .seconds(3600), smsCode: "230r", priceCHF: 1.30, priceEUR: 1.30, category: .frenchZoneTickets, userType: .jeune),
        TicketInfo(title: "Billet local Zone 240", duration: .seconds(3600), smsCode: "240", priceCHF: 1.60, priceEUR: 1.60, category: .frenchZoneTickets, userType: .adulte),
        TicketInfo(title: "Billet local Zone 240 (jeune)", duration: .seconds(3600), smsCode: "240r", priceCHF: 1.30, priceEUR: 1.30, category: .frenchZoneTickets, userType: .jeune),
        TicketInfo(title: "Billet local Zone 250", duration: .seconds(3600), smsCode: "250", priceCHF: 1.60, priceEUR: 1.60, category: .frenchZoneTickets, userType: .adulte),
        TicketInfo(title: "Billet local Zone 250 (jeune)", duration: .seconds(3600), smsCode: "250r", priceCHF: 1.30, priceEUR: 1.30, category: .frenchZoneTickets, userType: .jeune)
    ]
    
    public init() {}
    public func tickets(for category: TicketCategory) -> [TicketInfo] {
        return tickets.filter { $0.category == category }
    }
}
