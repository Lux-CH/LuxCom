//
//  LineColors.swift
//  LuxCom
//
//  Created by Constantin Clerc on 25.02.2025.
//
//  Updated colors from https://www.tpg.ch/fr/lignes
//  Old lines from tpg.fandom.com

import SwiftUI

public struct LineColor: Hashable, Sendable {
    public var line: String
    public var color: Color
    public var textColor: Color = .white
}

public struct LineColors {
    static let tpgLinesColor: [String: LineColor] = {
        var colors = [
            LineColor(line: "1", color: Color(hex: "5a1e82")),
            LineColor(line: "2", color: Color(hex: "D2DB4A"), textColor: .black),
            LineColor(line: "3", color: Color(hex: "B82F89")),
            LineColor(line: "5", color: Color(hex: "00ACE7")),
            LineColor(line: "6", color: Color(hex: "008CBE")),
            LineColor(line: "7", color: Color(hex: "00A828")),
            LineColor(line: "8", color: Color(hex: "84471C")),
            LineColor(line: "9", color: Color(hex: "E2001D")),
            LineColor(line: "10", color: Color(hex: "006E3D")),
            LineColor(line: "11", color: Color(hex: "82419E")),
            LineColor(line: "12", color: Color(hex: "F5A300"), textColor: .black),
            // https://fr.wikipedia.org/wiki/Ligne_13_du_tramway_de_Genève
            LineColor(line: "13", color: Color(hex: "4CB847")),
            LineColor(line: "14", color: Color(hex: "5A1E82")),
            LineColor(line: "15", color: Color(hex: "84471C")),
            // https://fr.wikipedia.org/wiki/Ligne_16_du_tramway_de_Genève
            LineColor(line: "16", color: Color(hex: "F387B7")),
            LineColor(line: "17", color: Color(hex: "00ACE7"), textColor: .black),
            LineColor(line: "18", color: Color(hex: "B82F89")),
            LineColor(line: "19", color: Color(hex: "A05909")),
            LineColor(line: "20", color: Color(hex: "00A828")),
            LineColor(line: "21", color: Color(hex: "78003C")),
            LineColor(line: "22", color: Color(hex: "5A1E82")),
            LineColor(line: "23", color: Color(hex: "B82F89")),
            LineColor(line: "25", color: Color(hex: "A05909")),
            LineColor(line: "28", color: Color(hex: "82419E")),
            LineColor(line: "31", color: Color(hex: "00B0A4")),
            LineColor(line: "32", color: Color(hex: "89CBBE"), textColor: .black),
            LineColor(line: "33", color: Color(hex: "00B0A4")),
            LineColor(line: "34", color: Color(hex: "89CBBE"), textColor: .black),
            LineColor(line: "35", color: Color(hex: "666666")),
            LineColor(line: "36", color: Color(hex: "666666")),
            LineColor(line: "37", color: Color(hex: "005F61")),
            LineColor(line: "38", color: Color(hex: "005F61")),
            LineColor(line: "39", color: Color(hex: "00B0A4")),
            LineColor(line: "40", color: Color(hex: "89CBBE"), textColor: .black),
            LineColor(line: "41", color: Color(hex: "00B0A4")),
            LineColor(line: "42", color: Color(hex: "00B0A4")),
            LineColor(line: "43", color: Color(hex: "89CBBE"), textColor: .black),
            LineColor(line: "44", color: Color(hex: "00B0A4")),
            LineColor(line: "45", color: Color(hex: "89CBBE"), textColor: .black),
            LineColor(line: "46", color: Color(hex: "00B0A4")),
            LineColor(line: "47", color: Color(hex: "00B0A4")),
            LineColor(line: "48", color: Color(hex: "89CBBE"), textColor: .black),
            // https://tpg.fandom.com/fr/wiki/Ligne_49
            LineColor(line: "49", color: Color(hex: "005E63")),
            LineColor(line: "50", color: Color(hex: "00B0A4")),
            LineColor(line: "51", color: Color(hex: "00B0A4")),
            LineColor(line: "52", color: Color(hex: "89CBBE"), textColor: .black),
            LineColor(line: "53", color: Color(hex: "89CBBE"), textColor: .black),
            LineColor(line: "54", color: Color(hex: "89CBBE"), textColor: .black),
            LineColor(line: "55", color: Color(hex: "005F61")),
            LineColor(line: "56", color: Color(hex: "009999")),
            LineColor(line: "57", color: Color(hex: "89CBBE"), textColor: .black),
            // https://tpg.fandom.com/fr/wiki/Ligne_58
            LineColor(line: "58", color: Color(hex: "02B1B0")),
            LineColor(line: "59", color: Color(hex: "005F61")),
            LineColor(line: "60", color: Color(hex: "EC619F")),
            LineColor(line: "61", color: Color(hex: "F5B5D2"), textColor: .black),
            LineColor(line: "62", color: Color(hex: "EC619F")), // became 82
            LineColor(line: "63", color: Color(hex: "F5B5D2")),
            LineColor(line: "64", color: Color(hex: "EC619F")),
            LineColor(line: "66", color: Color(hex: "F5B5D2"), textColor: .black),
            LineColor(line: "67", color: Color(hex: "F5B5D2"), textColor: .black),
            LineColor(line: "68", color: Color(hex: "EC619F")),
            LineColor(line: "69", color: Color(hex: "F5B5D2"), textColor: .black),
            LineColor(line: "70", color: Color(hex: "00B0A4")),
            LineColor(line: "71", color: Color(hex: "005F61")),
            LineColor(line: "72", color: Color(hex: "89CBBE"), textColor: .black),
            LineColor(line: "73", color: Color(hex: "005F61")),
            LineColor(line: "74", color: Color(hex: "89CBBE"), textColor: .black),
            LineColor(line: "75", color: Color(hex: "005F61")),
            LineColor(line: "76", color: Color(hex: "70C4B4")),
            LineColor(line: "77", color: Color(hex: "70C4B4")),
            LineColor(line: "78", color: Color(hex: "F5B5D2")),
            LineColor(line: "80", color: Color(hex: "FF9BAA"), textColor: .black),
            LineColor(line: "82", color: Color(hex: "EC619F")),
            LineColor(line: "83", color: Color(hex: "EC619F")),
            LineColor(line: "91", color: Color(hex: "005F61")),
            LineColor(line: "92", color: Color(hex: "89CBBE"), textColor: .black),
            LineColor(line: "A", color: Color(hex: "FF7E00")),
            LineColor(line: "E", color: Color(hex: "FF7E00")),
            LineColor(line: "G", color: Color(hex: "FF9BAA")),
            LineColor(line: "L", color: Color(hex: "FF7E00")),
            // france
            LineColor(line: "M", color: Color(hex: "00A828"), textColor: .black),
            LineColor(line: "N", color: Color(hex: "008CBE"), textColor: .black),
            LineColor(line: "271", color: Color(hex: "FFDC00")),
            LineColor(line: "272", color: Color(hex: "00B0A4")),
            LineColor(line: "274", color: Color(hex: "EC619F")),
            
            // scolaire
            LineColor(line: "C1", color: Color(hex: "000000")),
            LineColor(line: "C3", color: Color(hex: "000000")),
            LineColor(line: "C4", color: Color(hex: "000000")),
            LineColor(line: "C5", color: Color(hex: "000000")),
            LineColor(line: "C6", color: Color(hex: "000000")),
            LineColor(line: "C7", color: Color(hex: "000000")),
            LineColor(line: "C8", color: Color(hex: "000000")),
            LineColor(line: "C9", color: Color(hex: "000000")),
            
            // express
            LineColor(line: "E+", color: Color(hex: "000000")),
            LineColor(line: "G+", color: Color(hex: "000000")),
            
            LineColor(line: "94", color: Color(hex: "000000")),
            LineColor(line: "96", color: Color(hex: "000000")),
            LineColor(line: "97", color: Color(hex: "6CB43F")),

            // trains
            LineColor(line: "RL1", color: Color(hex: "E4023A")),
            LineColor(line: "RL2", color: Color(hex: "0385CD")),
            LineColor(line: "RL3", color: Color(hex: "64B32E")),
            LineColor(line: "RL4", color: Color(hex: "F8B003")),
            LineColor(line: "RL5", color: Color(hex: "C0096F")),
            LineColor(line: "RL6", color: Color(hex: "019AAA")),
            
            // mouettes
            LineColor(line: "M1", color: Color(hex: "0076BA")),
            LineColor(line: "M2", color: Color(hex: "FF6600")),
            LineColor(line: "M3", color: Color(hex: "068A33")),
            LineColor(line: "M4", color: Color(hex: "B10D28")),
            
            // navettes aeroport
            LineColor(line: "A", color: Color(hex: "F58428")),
            LineColor(line: "A1", color: Color(hex: "7D78B7")),
            LineColor(line: "A2", color: Color(hex: "00744A")),
            LineColor(line: "A3", color: Color(hex: "0DAE4B")),
            LineColor(line: "A4", color: Color(hex: "009FDF")),
            LineColor(line: "A5", color: Color(hex: "F167A7")),
            LineColor(line: "A6", color: Color(hex: "DA2031")),
            
            // tpn
            LineColor(line: "803", color: Color(hex: "E63023")),
            LineColor(line: "804", color: Color(hex: "009640")),
            LineColor(line: "805", color: Color(hex: "F07D00")),
            LineColor(line: "810", color: Color(hex: "C693C2")),
            LineColor(line: "811", color: Color(hex: "96358C")),
            LineColor(line: "813", color: Color(hex: "F39DA9")),
            LineColor(line: "814", color: Color(hex: "00437A")),
            LineColor(line: "815", color: Color(hex: "AD222B")),
            LineColor(line: "818", color: Color(hex: "85431D")),
            LineColor(line: "891", color: Color(hex: "FFE52D")),
            LineColor(line: "R55", color: Color(hex: "EE2720")),
        ]
        return Dictionary(uniqueKeysWithValues: colors.map { ($0.line, $0) })
    }()
    
    public static func color(for line: String) -> Color? {
        return tpgLinesColor[line]?.color
    }
    
    public static func textColor(for line: String) -> Color? {
        return tpgLinesColor[line]?.textColor
    }
}

// https://stackoverflow.com/a/56874327/22819688
public extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }

        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue: Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}
