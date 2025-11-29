//
//  ColorExtensions.swift
//  personal expense tracker
//
//  Created by 5433 on 10/27/25.
//

import SwiftUI

extension Color {
    init(hex: String) {
        let scanner = Scanner(string: hex)
        var rgbValue: UInt64 = 0

        if hex.hasPrefix("#") {
            _ = scanner.scanCharacter()
        }

        scanner.scanHexInt64(&rgbValue)

        let r = Double((rgbValue >> 16) & 0xFF) / 255.0
        let g = Double((rgbValue >> 8) & 0xFF) / 255.0
        let b = Double(rgbValue & 0xFF) / 255.0

        self.init(red: r, green: g, blue: b)
    }
    
    func toHex() -> String? {
            #if os(iOS)
            let uiColor = UIColor(self)
            var r: CGFloat = 0
            var g: CGFloat = 0
            var b: CGFloat = 0
            var a: CGFloat = 0

            guard uiColor.getRed(&r, green: &g, blue: &b, alpha: &a) else {
                return nil
            }

            let ri = Int(r * 255)
            let gi = Int(g * 255)
            let bi = Int(b * 255)
            return String(format: "#%02X%02X%02X", ri, gi, bi)
            #else
            return nil
            #endif
        }
}
