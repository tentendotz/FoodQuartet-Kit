//
//  BaseViewController.swift
//  FoodQuartet-Kit
//
//  Created by tetsuta matsuyama on 2023/12/22.
//

import UIKit

class BaseViewController: UIViewController {
    
    static let okAction = UIAlertAction(title: K.L10n.ok, style: .default)
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    // MARK: - Common Helpers
    
    /// Display an alert with a custom title, message, and user-selectable actions.
    ///
    /// - By default, the `actions` parameter includes an OK action.
    func displayAlert(title: String, message: String?, actions: [UIAlertAction] = [okAction], style: UIAlertController.Style = .alert) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: style)
        actions.forEach { alert.addAction($0) }
        present(alert, animated: true)
    }
}
