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
}


extension MonthPickerViewController {
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    // MARK: - User Interaction
    
    @IBAction private func backPressed(_ sender: UIBarButtonItem) {
    }

    @IBAction private func donePressed(_ sender: UIButton) {
    }
}
