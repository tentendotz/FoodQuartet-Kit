//
//  UIColor+HexColor.swift
//  FoodQuartet-Kit
//
//  Created by tetsuta matsuyama on 2023/07/02.
//

import UIKit

extension UIColor {
    
    enum Hex: Int {
        // Season Colors
        case springHex = 0xFF8A8A
        case summerHex = 0xF19900
        case fallHex = 0xD94C3D
        case winterHex = 0x4C80B3
        
        // Food Kind Colors
        case vegetableHex = 0x219947
        case mushroomHex = 0xA2845E
        case seafoodHex = 0x3A6B95
        case meatHex = 0xE74C3C
        case fruitHex = 0xFAB1A0
        case othersHex = 0xBDC3C7
    }
    
    static func calculateColor(_ type: Hex) -> UIColor {
        return UIColor(hex: type.rawValue)
    }
}


extension UIColor {

    convenience init(hex: Int, alpha: CGFloat = 1) {
        let r = CGFloat((hex & 0xFF0000) >> 16) / 255.0
        let g = CGFloat((hex & 0x00FF00) >> 8) / 255.0
        let b = CGFloat((hex & 0x0000FF) >> 0) / 255.0
        self.init(red: r, green: g, blue: b, alpha: alpha)
    }
    
    convenience init?(hexString: String, alpha: CGFloat = 1) {
        var hex = hexString
        if hex.hasPrefix("#") {
            hex.removeFirst(1)
        }
        if hex.lowercased().hasPrefix("0x") {
            hex.removeFirst(2)
        }
        
        let scanner = Scanner(string: hex)
        var hexNumber: UInt64 = 0
        guard scanner.scanHexInt64(&hexNumber) else { return nil }

        switch hex.count {
        case 6:
            let r = CGFloat((hexNumber & 0xFF0000) >> 16) / 255.0
            let g = CGFloat((hexNumber & 0x00FF00) >> 8) / 255.0
            let b = CGFloat((hexNumber & 0x0000FF) >> 0) / 255.0
            self.init(red: r, green: g, blue: b, alpha: alpha)
        case 8:
            let r = CGFloat((hexNumber & 0xFF000000) >> 24) / 255.0
            let g = CGFloat((hexNumber & 0x00FF0000) >> 16) / 255.0
            let b = CGFloat((hexNumber & 0x0000FF00) >> 8) / 255.0
            let a = CGFloat((hexNumber & 0x000000FF) >> 0) / 255.0
            self.init(red: r, green: g, blue: b, alpha: a)
        default:
            return nil
        }
    }
}
