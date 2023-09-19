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
        
        title = "Search Recipe"
        navigationItem.rightBarButtonItem = editButtonItem
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(WebSearchCell.self, forCellReuseIdentifier: K.WebSearchVC.cellIdentifier)
    }
}


extension WebSearchViewController {
    
    // MARK: - User Interaction
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        tableView.setEditing(editing, animated: true)
    }
    
    @IBAction private func safariPressed(_ sender: UIButton) {
    }
}


// MARK: - UITableViewDataSource & UITableViewDelegate

extension WebSearchViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if currentItems.isEmpty {
            // TODO: - Localization
            tableView.createEmptyState(title: "Oops! You have not selected the item.", message: "When you tap some foods, you'll see them here.")
        } else {
            tableView.restore()
        }
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
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let removed = currentItems.remove(at: sourceIndexPath.row)
        currentItems.insert(removed, at: destinationIndexPath.row)
    }
}
