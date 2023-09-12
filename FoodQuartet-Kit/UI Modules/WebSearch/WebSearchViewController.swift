//
//  WebSearchViewController.swift
//  FoodQuartet-Kit
//
//  Created by tetsuta matsuyama on 2023/07/01.
//

import UIKit

final class WebSearchViewController: UIViewController {
    
    @IBOutlet private weak var tableView: UITableView!
    var currentItems = [Food]()
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    // MARK: - User Interaction
    
    @IBAction private func safariPressed(_ sender: UIButton) {
    }
}
