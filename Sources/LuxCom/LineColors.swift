//
//  LineColors.swift
//  LuxCom
//
//  Created by Constantin Clerc on 25.02.2025.
//
//  Updated colors from https://www.tpg.ch/fr/lignes
//  Old lines from tpg.fandom.com

import SwiftUICore

struct LineColor {
    var line: String
    var color: Color
    var textColor: Color = .white
}

struct LineColors {
    let tpgLinesColor: [LineColor] =
    [LineColor(line: "1", color: Color(hex: "5a1e82")),
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
     LineColor(line: "49", color: Color(hex: "015E63")),
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
     LineColor(line: "75", color: Color(hex: "005F6")),
     LineColor(line: "76", color: Color(hex: "70C4B4")),
     LineColor(line: "77", color: Color(hex: "70C4B4")),
     LineColor(line: "78", color: Color(hex: "F5B5D2")),
     LineColor(line: "80", color: Color(hex: "EC619F"), textColor: .black),
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
     LineColor(line: "97", color: Color(hex: "000000"))]
}

// https://stackoverflow.com/a/56874327/22819688
extension Color {
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
