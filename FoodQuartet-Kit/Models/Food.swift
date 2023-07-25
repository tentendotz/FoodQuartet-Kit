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
