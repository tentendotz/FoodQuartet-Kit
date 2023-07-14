//
//  FoodBrain.swift
//  FoodQuartet-Kit
//
//  Created by tetsuta matsuyama on 2023/07/13.
//

import UIKit

struct FoodBrain {
    
    var items = [Food]()
}


extension FoodBrain {
    
    private func generateFoods() -> [Food] {
        var foods = [Food]()
        let components = foodsRawData.components(separatedBy: .newlines)
        
        for line in components {
            let foodData = line.split(separator: "/")
            let name = String(foodData[0])
            let hex = String(foodData[1])
            let rawNumbers = foodData[3].split(separator: ",").compactMap { Int($0) }
            
            let hexColor = UIColor(hexString: hex)
            
            // TODO: - Creating food class object

        }
        return foods
    }
    
    
    // MARK: - Data Converting Helpers
    
    private func classifySeasons(from numbers: [Int]) -> Set<String> {
        var seasons = Set<String>()
        for number in numbers {
            switch number {
            case 3...5:
                seasons.insert(K.L10n.spring)
            case 6...8:
                seasons.insert(K.L10n.summer)
            case 9...11:
                seasons.insert(K.L10n.fall)
            case 12, 1...2:
                seasons.insert(K.L10n.winter)
            default:
                print("Error classifying season, '\(number)' is out of conditions.")
            }
        }
        return seasons
    }
    
}
