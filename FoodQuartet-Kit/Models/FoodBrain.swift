//
//  FoodBrain.swift
//  FoodQuartet-Kit
//
//  Created by tetsuta matsuyama on 2023/07/13.
//

import UIKit
import SwiftCSV

struct FoodBrain {
    
    lazy var items = generateFoods()
    
    mutating func filteredFoods(with activeRules: [String], except blockList: [Food]? = nil, limit: Int? = nil) -> [Food] {
        var filtered = items.filter { $0.harvestTime.isSuperset(of: activeRules) }
        
        if let blockedItems = blockList {
            filtered = filtered.filter { !blockedItems.contains($0) }
        }
        
        let shuffled = filtered.shuffled()
        guard let maxLimit = limit else { return shuffled }
        
        // If the assertion fails, it is possible that the filtered items are too restricted.
        assert(shuffled.count >= maxLimit, "The item count is insufficient.")
        
        let someAllowed = Array(shuffled.prefix(maxLimit))
        return someAllowed
    }
}


// MARK: - Raw Data Parsing

extension FoodBrain {
    
    private func generateFoods() -> [Food] {
        var foods = [Food]()
        let fileName = "FoodsRawData"
        
        guard let csvRows = loadCSV(from: fileName) else {
            fatalError("Failed to load '\(fileName).csv' from the app bundle.")
        }
        
        let components = foodsRawData.components(separatedBy: .newlines)
        
        for line in components {
            let foodData = line.split(separator: "/")
            let name = NSLocalizedString(String(foodData[0]), comment: "")
            let hex = String(foodData[1])
            let group = Food.Kind(alias: foodData[2])
            let rawNumbers = foodData[3].split(separator: ",").compactMap { Int($0) }
            
            let color = UIColor(hexString: hex) ?? {
                assertionFailure("\(name)'s \(hex) is an invalid value.")
                
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
    
    private func loadCSV(from fileName: String, type: String = "csv") -> [[String]]? {
        do {
            let csv = try CSV<Enumerated>(name: fileName, extension: type, delimiter: .comma, loadColumns: false)
            return csv?.rows
            
        } catch let parseError as CSVParseError {
            print(parseError)
        } catch {
            print(error)
        }
        return nil
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
