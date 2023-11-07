//
//  MonthPickerViewController.swift
//  FoodQuartet-Kit
//
//  Created by tetsuta matsuyama on 2023/07/01.
//

import UIKit

final class MonthPickerViewController: UIViewController {
    
    @IBOutlet private weak var tableView: UITableView!
    
    private var twelveMonths = [[String]]()
    
    
    // MARK: - Section Handling
    
    enum Section: Int, CaseIterable {
        case spring = 0, summer, fall, winter
    }
}


extension MonthPickerViewController {
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        twelveMonths = populateMonths()

        // Do any additional setup after loading the view.
    }
    
    
    // MARK: - User Interaction
    
    @IBAction private func backPressed(_ sender: UIBarButtonItem) {
    }

    @IBAction private func donePressed(_ sender: UIButton) {
    }
    
    
    // MARK: - Additional Helpers
    
    private func populateMonths() -> [[String]] {
        let springMonths = generateMonths(from: [3, 4, 5])
        let summerMonths = generateMonths(from: [6, 7, 8])
        let fallMonths = generateMonths(from: [9, 10, 11])
        let winterMonths = generateMonths(from: [12, 1, 2])
        
        return [springMonths, summerMonths, fallMonths, winterMonths]
    }
    
    private func generateMonths(from numbers: [Int]) -> [String] {
        let months = numbers.map { DateFormatter.fullNameOfMonth(from: $0) }
        return months
    }
}
