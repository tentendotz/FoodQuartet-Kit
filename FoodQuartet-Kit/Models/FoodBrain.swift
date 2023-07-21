//
//  FoodBrain.swift
//  FoodQuartet-Kit
//
//  Created by tetsuta matsuyama on 2023/07/13.
//

import UIKit

struct FoodBrain {
    
    lazy var items = generateFoods()
}


// MARK: - Raw Data Parsing

extension FoodBrain {
    
    private func generateFoods() -> [Food] {
        var foods = [Food]()
        let components = foodsRawData.components(separatedBy: .newlines)
        
        for line in components {
            let foodData = line.split(separator: "/")
            let name = String(foodData[0])
            let hex = String(foodData[1])
            let rawNumbers = foodData[2].split(separator: ",").compactMap { Int($0) }
            
            let hexColor = UIColor(hexString: hex)!
            
            let seasons = classifySeasons(from: rawNumbers)
            let months = rawNumbers.map { DateFormatter.fullNameOfMonth(from: $0) }
            let harvestTime = seasons.union(months)

            foods.append(Food(name: name, color: hexColor, harvestTime: harvestTime))
        }
        return foods
    }
    
    
    // MARK: - Data Generating Helpers
    
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
