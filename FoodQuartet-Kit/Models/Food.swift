//
//  Food.swift
//  FoodQuartet-Kit
//
//  Created by tetsuta matsuyama on 2023/07/12.
//

import UIKit

final class Food {
    
    let name: String
    let color: UIColor
    let harvestTime: Set<String>
    var isSelected = false
    
    init(name: String, color: UIColor, harvestTime: Set<String>) {
        self.name = name
        self.color = color
        self.harvestTime = harvestTime
    }
}


extension Food {
    
    // MARK: - Food Group Enumeration
    
    enum Kind: String {
        case vegetable, mushroom, seafood, meat, fruit, others
        
        init(alias: Substring) {
            switch alias.lowercased() {
            case "veg": self = .vegetable
            case "mush": self = .mushroom
            case "fish": self = .seafood
            case "sea": self = .seafood
            case "meat": self = .meat
            case "fruit": self = .fruit
            default: self = .others
            }
        }
        
        // TODO: - Implement localization...
        var localized: String {
            switch self {
            case .vegetable: return "Vegetable"
            case .mushroom: return "Mushroom"
            case .seafood: return "Seafood"
            case .meat: return "Meat"
            case .fruit: return "Fruit"
            case .others: return "Others"
            }
        }
    }
}
