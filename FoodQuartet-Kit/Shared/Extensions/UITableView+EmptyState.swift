//
//  UITableView+EmptyState.swift
//  FoodQuartet-Kit
//
//  Created by tetsuta matsuyama on 2023/08/07.
//

import UIKit

extension UITableView {
    
    /// Handles an empty data set using UITableView's backgroundView.
    /// - If the data source has no data, you can provide a friendly message to the user.
    func createEmptyState(title: String, message: String) {
        let emptyView = UIView(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
        let titleLabel = UILabel()
        let messageLabel = UILabel()
        
        titleLabel.text = title
        titleLabel.textColor = UIColor.label
        titleLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 18)
        titleLabel.numberOfLines = 0
        titleLabel.textAlignment = .center
        
        messageLabel.text = message
        messageLabel.textColor = UIColor.secondaryLabel
        messageLabel.font = UIFont(name: "HelveticaNeue-Regular", size: 16)
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        
        // Setting up Auto Layout constraints for the title and message labels
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        emptyView.addSubview(titleLabel)
        emptyView.addSubview(messageLabel)
        
        let inset = CGFloat(20)
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: emptyView.centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: emptyView.centerYAnchor),
            messageLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: inset),
            messageLabel.leadingAnchor.constraint(equalTo: emptyView.leadingAnchor, constant: inset),
            messageLabel.trailingAnchor.constraint(equalTo: emptyView.trailingAnchor, constant: -inset)
        ])
        
        self.backgroundView = emptyView
    }
    
    /// Restores the original state of the view by removing UITableView's backgroundView.
    func restore() {
        self.backgroundView = nil
    }
}
