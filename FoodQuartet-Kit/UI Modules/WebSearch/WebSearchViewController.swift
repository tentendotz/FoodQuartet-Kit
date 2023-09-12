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

        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(WebSearchCell.self, forCellReuseIdentifier: K.WebSearchVC.cellIdentifier)
    }
    
    
    // MARK: - User Interaction
    
    @IBAction private func safariPressed(_ sender: UIButton) {
    }
}


// MARK: - UITableViewDataSource & UITableViewDelegate

extension WebSearchViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: K.WebSearchVC.cellIdentifier, for: indexPath) as? WebSearchCell else {
            fatalError("Unable to dequeue WebSearchCell")
        }
        let foodName = currentItems[indexPath.row].name
        let foodGroup = "(\(currentItems[indexPath.row].group.localized))"
        cell.configureCell(title: foodName, secondaryTitle: foodGroup)
        
        return cell
    }
}
