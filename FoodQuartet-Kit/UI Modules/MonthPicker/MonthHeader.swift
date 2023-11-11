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
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
