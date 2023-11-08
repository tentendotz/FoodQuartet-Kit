//
//  MonthCell.swift
//  FoodQuartet-Kit
//
//  Created by tetsuta matsuyama on 2023/11/06.
//

import UIKit

final class MonthCell: UITableViewCell {

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


extension MonthCell {
    
    func configureCell(title: String) {
        self.configurationUpdateHandler = { cell, state in
            var contentConfig = cell.defaultContentConfiguration().updated(for: state)
            contentConfig.text = title
            contentConfig.textProperties.color = UIColor.label
            contentConfig.image = UIImage(systemName: "square")
            contentConfig.imageProperties.tintColor = UIColor.secondaryLabel
            
            var backgroundConfig = UIBackgroundConfiguration.listPlainCell().updated(for: state)
            backgroundConfig.backgroundColor = UIColor(named: K.Colors.secondary)
            
            if state.isSelected {
                contentConfig.image = UIImage(systemName: "checkmark.square")
                contentConfig.imageProperties.tintColor = UIColor.label
                backgroundConfig.backgroundColor = UIColor(named: K.Colors.tertiary)
            }
            cell.contentConfiguration = contentConfig
            cell.backgroundConfiguration = backgroundConfig
        }
    }
}
