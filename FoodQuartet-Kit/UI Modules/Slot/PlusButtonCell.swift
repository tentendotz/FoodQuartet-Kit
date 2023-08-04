//
//  PlusButtonCell.swift
//  FoodQuartet-Kit
//
//  Created by tetsuta matsuyama on 2023/08/04.
//

import UIKit

final class PlusButtonCell: UITableViewCell {
    
    let button = UIButton()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.backgroundColor = UIColor(named: K.Colors.primary)
        createSubview(in: contentView)
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
    
}
