//
//  Food.swift
//  FoodQuartet-Kit
//
//  Created by tetsuta matsuyama on 2023/07/12.
//

import UIKit

final class Food: Hashable {
    
    let id = UUID()
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
    
    
    // MARK: - Conforming to the Hashable
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: Food, rhs: Food) -> Bool {
        return lhs.id == rhs.id
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
        
        var localized: String {
            switch self {
            case .vegetable: return K.L10n.vegetable
            case .mushroom: return K.L10n.mushroom
            case .seafood: return K.L10n.seafood
            case .meat: return K.L10n.meat
            case .fruit: return K.L10n.fruit
            case .others: return K.L10n.others
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
