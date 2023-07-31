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
    let group: Kind
    let harvestTime: Set<String>
    var isSelected = false
    
    init(name: String, color: UIColor, group: Kind, harvestTime: Set<String>) {
        self.name = name
        self.color = color
        self.group = group
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


extension Food {
    
    // MARK: - Data Manipulation Method
    
    func retrieveSeasons() -> Set<String> {
        let fourSeasons: Set = [K.L10n.spring, K.L10n.summer, K.L10n.fall, K.L10n.winter]
        let itemSeasons = self.harvestTime.intersection(fourSeasons)
        return itemSeasons
    }
}
