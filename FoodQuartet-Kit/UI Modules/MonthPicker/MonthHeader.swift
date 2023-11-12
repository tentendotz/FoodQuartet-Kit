//
//  MonthHeader.swift
//  FoodQuartet-Kit
//
//  Created by tetsuta matsuyama on 2023/11/08.
//

import UIKit

final class MonthHeader: UITableViewHeaderFooterView {
    
    private let imageView = UIImageView()
    private let titleLabel = UILabel()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        createSubview(in: contentView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


extension MonthHeader {
    
    private func createSubview(in contentView: UIView) {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(imageView)
        contentView.addSubview(titleLabel)
        
        let size = CGFloat(30)
        let inset = CGFloat(6)
        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalToConstant: size),
            imageView.heightAnchor.constraint(equalToConstant: size),
            imageView.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor, constant: -inset),
            imageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: inset),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    func configureHeader(title: String?, image: UIImage?, color: UIColor?) {
        titleLabel.text = title
        titleLabel.textColor = UIColor.secondaryLabel
        imageView.image = image
        imageView.tintColor = UIColor.secondaryLabel
        
        var backgroundConfig = UIBackgroundConfiguration.listPlainHeaderFooter()
        backgroundConfig.backgroundColor = color
        self.backgroundConfiguration = backgroundConfig
    }
}
