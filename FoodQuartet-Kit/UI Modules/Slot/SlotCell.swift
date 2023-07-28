//
//  SlotCell.swift
//  FoodQuartet-Kit
//
//  Created by tetsuta matsuyama on 2023/07/01.
//

import UIKit

class SlotCell: UITableViewCell {
    
    // Food name and color
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var itemView: UIView!
    @IBOutlet private weak var pinnedImageView: UIImageView!

    // Season icons
    @IBOutlet private weak var captionLabel: UILabel!
    @IBOutlet private weak var springView: UIView!
    @IBOutlet private weak var summerView: UIView!
    @IBOutlet private weak var fallView: UIView!
    @IBOutlet private weak var winterView: UIView!
    @IBOutlet private weak var springImageView: UIImageView!
    @IBOutlet private weak var summerImageView: UIImageView!
    @IBOutlet private weak var fallImageView: UIImageView!
    @IBOutlet private weak var winterImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}


extension SlotCell {
    
    func configureCell(title: String, color: UIColor, isSelected: Bool) {
        titleLabel.text = title
        itemView.layer.borderColor = color.cgColor
        if isSelected {
            pinnedImageView.image = UIImage(systemName: "pin.circle.fill")
            itemView.backgroundColor = color.withAlphaComponent(0.4)
        } else {
            pinnedImageView.image = UIImage(systemName: "circle.dotted")
            itemView.backgroundColor = UIColor.clear
        }
    }
}
