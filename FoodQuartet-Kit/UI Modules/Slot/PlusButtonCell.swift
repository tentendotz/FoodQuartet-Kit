//
//  PlusButtonCell.swift
//  FoodQuartet-Kit
//
//  Created by tetsuta matsuyama on 2023/08/04.
//

import UIKit

final class PlusButtonCell: UITableViewCell {
    
    let button = UIButton()
    
    var isEnabled = true {
        didSet {
            button.setNeedsUpdateConfiguration()
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.backgroundColor = UIColor(named: K.Colors.primary)
        createSubview(in: contentView)
        configureButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


extension PlusButtonCell {
    
    private func createSubview(in contentView: UIView) {
        button.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(button)
        
        let inset = CGFloat(50)
        NSLayoutConstraint.activate([
            contentView.heightAnchor.constraint(equalToConstant: 50),
            button.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            button.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: inset),
            button.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -inset)
        ])
    }
    
    private func configureButton() {
        var config = UIButton.Configuration.gray()
        config.imagePadding = 4
        config.cornerStyle = .small
        let symbolConfig = UIImage.SymbolConfiguration(weight: .medium)
        
        button.configurationUpdateHandler = { [weak self] button in
            guard let self else { return }
            if self.isEnabled {
                button.isUserInteractionEnabled = true
                config.image = UIImage(systemName: "plus", withConfiguration: symbolConfig)
                config.title = .none
                config.baseForegroundColor = UIColor.systemGreen
                config.baseBackgroundColor = UIColor(named: K.Colors.tertiary)
                config.buttonSize = .medium
            } else {
                button.isUserInteractionEnabled = false
                config.image = UIImage(systemName: "rectangle.and.hand.point.up.left.filled", withConfiguration: symbolConfig)
                // TODO: - Implement localization...
                config.title = "No more available items."
                config.baseForegroundColor = UIColor.tertiaryLabel
                config.baseBackgroundColor = UIColor.clear
                config.buttonSize = .small
            }
            button.configuration = config
        }
    }
}
