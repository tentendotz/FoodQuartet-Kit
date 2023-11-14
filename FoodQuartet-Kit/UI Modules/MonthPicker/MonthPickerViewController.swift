//
//  MonthPickerViewController.swift
//  FoodQuartet-Kit
//
//  Created by tetsuta matsuyama on 2023/07/01.
//

import UIKit


protocol MonthPickerDelegate: AnyObject {
    
    func updateFilter(from monthPicker: MonthPickerViewController, section: MonthPickerViewController.Section, selectedMonth: String)
}


final class MonthPickerViewController: UIViewController {
    
    @IBOutlet private weak var tableView: UITableView!
    
    private var twelveMonths = [[String]]()
    weak var delegate: MonthPickerDelegate?
    
    
    // MARK: - Section Handling
    
    enum Section: Int, CaseIterable {
        case spring = 0, summer, fall, winter
        
        var headerTitle: String {
            switch self {
            case .spring: return "Spring"
            case .summer: return "Summer"
            case .fall: return "Fall"
            case .winter: return "Winter"
            }
        }
        
        var headerImage: UIImage? {
            switch self {
            case .spring: return UIImage(systemName: "circle.hexagongrid")
            case .summer: return UIImage(systemName: "sun.max")
            case .fall: return UIImage(systemName: "leaf")
            case .winter: return UIImage(systemName: "snowflake")
            }
        }
        
        var headerColor: UIColor {
            let color: UIColor
            switch self {
            case .spring: color = UIColor.calculateColor(.springHex)
            case .summer: color = UIColor.calculateColor(.summerHex)
            case .fall: color = UIColor.calculateColor(.fallHex)
            case .winter: color = UIColor.calculateColor(.winterHex)
            }
            return color.withAlphaComponent(0.3)
        }
    }
}


extension MonthPickerViewController {
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        twelveMonths = populateMonths()
        
        title = K.L10n.selectMonth
        tableView.sectionHeaderHeight = 35.0
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(MonthCell.self, forCellReuseIdentifier: K.MonthPickerVC.cellIdentifier)
        tableView.register(MonthHeader.self, forHeaderFooterViewReuseIdentifier: K.MonthPickerVC.headerIdentifier)
    }
    
    
    // MARK: - User Interaction
    
    @IBAction private func backPressed(_ sender: UIBarButtonItem) {
        dismiss(animated: true)
    }
    
    @IBAction private func donePressed(_ sender: UIButton) {
        if let indexPath = tableView.indexPathForSelectedRow, let sectionKind = Section(rawValue: indexPath.section) {
            let monthName = twelveMonths[indexPath.section][indexPath.row]
            delegate?.updateFilter(from: self, section: sectionKind, selectedMonth: monthName)
        }
        dismiss(animated: true)
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


// MARK: - UITableViewDataSource & UITableViewDelegate

extension MonthPickerViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return Section.allCases.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return twelveMonths[section].count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: K.MonthPickerVC.headerIdentifier) as? MonthHeader else {
            fatalError("Unable to dequeue MonthHeader")
        }
        let sectionKind = Section(rawValue: section)
        header.configureHeader(title: sectionKind?.headerTitle, image: sectionKind?.headerImage, color: sectionKind?.headerColor)
        
        return header
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: K.MonthPickerVC.cellIdentifier, for: indexPath) as? MonthCell else {
            fatalError("Unable to dequeue MonthCell")
        }
        let monthName = twelveMonths[indexPath.section][indexPath.row]
        cell.configureCell(title: monthName)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        if let selectedIndexPath = tableView.indexPathForSelectedRow, selectedIndexPath == indexPath {
            tableView.deselectRow(at: indexPath, animated: false)
            return nil
        }
        return indexPath
    }
}
