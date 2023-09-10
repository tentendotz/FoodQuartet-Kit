//
//  WebSearchCell.swift
//  FoodQuartet-Kit
//
//  Created by tetsuta matsuyama on 2023/09/10.
//

import UIKit

final class WebSearchCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


extension WebSearchCell {
    
    func configureCell(title: String, secondaryTitle: String) {
        var contentConfig = defaultContentConfiguration()
        contentConfig.text = title
        contentConfig.textProperties.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        contentConfig.textProperties.color = UIColor.label
        contentConfig.textProperties.alignment = .center

        contentConfig.secondaryText = secondaryTitle
        contentConfig.secondaryTextProperties.font = UIFont.systemFont(ofSize: 14)
        contentConfig.secondaryTextProperties.color = UIColor.tertiaryLabel
        contentConfig.secondaryTextProperties.alignment = .center

        var backgroundConfig = UIBackgroundConfiguration.listPlainCell()
        backgroundConfig.backgroundColor = UIColor(named: K.Colors.secondary)
        
        self.contentConfiguration = contentConfig
        self.backgroundConfiguration = backgroundConfig
    }
}
