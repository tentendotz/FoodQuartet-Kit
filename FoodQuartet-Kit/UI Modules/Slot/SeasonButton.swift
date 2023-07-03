//
//  SeasonButton.swift
//  FoodQuartet-Kit
//
//  Created by tetsuta matsuyama on 2023/07/02.
//

import UIKit

final class SeasonButton: UIButton {

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func switchState(isSelected: Bool, backgroundColor: UIColor?) {
        self.isSelected = isSelected
        
        self.configurationUpdateHandler = { [unowned self] button in
            var config = button.configuration
            if self.isSelected {
                config?.baseForegroundColor = UIColor.white
                config?.baseBackgroundColor = backgroundColor
            } else {
                config?.baseForegroundColor = UIColor.label
                config?.baseBackgroundColor = UIColor(named: K.Colors.tertiary)
            }
            button.configuration = config
        }
    }
}
