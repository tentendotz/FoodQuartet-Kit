//
//  BaseViewController.swift
//  FoodQuartet-Kit
//
//  Created by tetsuta matsuyama on 2023/12/22.
//

import UIKit

class BaseViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    // MARK: - Common Helpers
    
    func displayAlert(title: String, message: String?, actions: [UIAlertAction], style: UIAlertController.Style = .alert) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: style)
        actions.forEach { alert.addAction($0) }
        present(alert, animated: true)
    }
}
