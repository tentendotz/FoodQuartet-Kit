//
//  FoodBrain.swift
//  FoodQuartet-Kit
//
//  Created by tetsuta matsuyama on 2023/07/13.
//

import UIKit

struct FoodBrain {
    
    lazy var items = generateFoods()
    
    mutating func filteredFoods(with activeRules: [String], except blockList: [Food]? = nil, limit: Int? = nil) -> [Food] {
        let filtered = items.filter { $0.harvestTime.isSuperset(of: activeRules) }
        
        
        
        guard let maxLimit = limit else { return filtered }
        let unselected = filtered.filter { !$0.isSelected }
        let someUnselected = Array(unselected.prefix(maxLimit))
        
        return someUnselected
    }
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
            let group = Food.Kind(alias: foodData[2])
            let rawNumbers = foodData[3].split(separator: ",").compactMap { Int($0) }
            
            let color = UIColor(hexString: hex) ?? {
                print("\(name)'s \(hex) is an invalid value.")
                
                switch group {
                case .vegetable: return UIColor.calculateColor(.vegetableHex)
                case .mushroom: return UIColor.calculateColor(.mushroomHex)
                case .seafood: return UIColor.calculateColor(.seafoodHex)
                case .meat: return UIColor.calculateColor(.meatHex)
                case .fruit: return UIColor.calculateColor(.fruitHex)
                case .others: return UIColor.calculateColor(.othersHex)
                }
            }()
            
            if rawNumbers.isEmpty { fatalError("Error generating food, The \(name) doesn't have any rawNumbers.") }
            guard rawNumbers.allSatisfy({ 1...12 ~= $0 }) else { fatalError("Error generating food, The \(name)'s '\(rawNumbers)' is out of range.") }
            
            let harvestTime = performConversion(from: rawNumbers)
            
            foods.append(Food(name: name, color: color, group: group, harvestTime: harvestTime))
        }
        return foods
    }
    
    
    // MARK: - Data Generating Helpers
    
    private func performConversion(from numbers: [Int]) -> Set<String> {
        let seasons = classifySeasons(from: numbers)
        let months = numbers.map { DateFormatter.fullNameOfMonth(from: $0) }
        return seasons.union(months)
    }
    
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
