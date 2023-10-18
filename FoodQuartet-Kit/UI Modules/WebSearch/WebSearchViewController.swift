//
//  WebSearchViewController.swift
//  FoodQuartet-Kit
//
//  Created by tetsuta matsuyama on 2023/07/01.
//

import UIKit
import SafariServices

final class WebSearchViewController: UIViewController {
    
    @IBOutlet private weak var tableView: UITableView!
    
    private let urlLoader = URLLoader()
    var currentItems = [Food]()
    
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = K.L10n.searchRecipe
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
        let foodNames = currentItems.map { $0.name }
        let googleSearch = Endpoint(site: .google, searchTerms: foodNames)
        
        do {
            let url = try urlLoader.request(target: googleSearch)
            let webVC = SFSafariViewController(url: url)
            present(webVC, animated: true)
            
        } catch let error as NSError {
            let okAction = UIAlertAction(title: K.L10n.ok, style: .default)
            displayAlert(title: error.localizedDescription, message: error.localizedFailureReason, actions: [okAction])
        }
    }
}


// MARK: - UITableViewDataSource & UITableViewDelegate

extension WebSearchViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if currentItems.isEmpty {
            tableView.createEmptyState(title: K.L10n.noItemSelected, message: K.L10n.tapBackButton)
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
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return tableView.isEditing ? .delete : .none
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let removed = currentItems.remove(at: sourceIndexPath.row)
        currentItems.insert(removed, at: destinationIndexPath.row)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            currentItems.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}
