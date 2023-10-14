//
//  UIViewController+Alert.swift
//  FoodQuartet-Kit
//
//  Created by tetsuta matsuyama on 2023/09/05.
//

import UIKit

extension UIViewController {
    
    func displayAlert(title: String, message: String?, actions: [UIAlertAction], style: UIAlertController.Style = .alert) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: style)
        actions.forEach { alert.addAction($0) }
        present(alert, animated: true)
    }
}
