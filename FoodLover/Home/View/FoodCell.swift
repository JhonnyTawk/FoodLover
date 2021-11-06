//
//  FoodCell.swift
//  FoodLover
//
//  Created by Jhonny on 11/6/21.
//

import Foundation
import UIKit
import Kingfisher

class FoodCell: UICollectionViewCell {
    
    @IBOutlet weak var foodImage: UIImageView! {
        didSet {
            foodImage.layer.cornerRadius = 5
            foodImage.clipsToBounds = true
        }
    }
    @IBOutlet weak var foodTitle: UILabel! {
        didSet {
            foodTitle.textColor = .systemBlue
            foodTitle.font = UIFont.systemFont(ofSize: 14)
        }
    }
    @IBOutlet weak var foodDuration: UILabel! {
        didSet {
            foodDuration.textColor = .systemGray
            foodDuration.font = UIFont.systemFont(ofSize: 12)
        }
    }
    @IBOutlet weak var foodDescription: UILabel! {
        didSet {
            foodDescription.textColor = .systemGray
            foodDescription.numberOfLines = 0
            foodDescription.font = UIFont.systemFont(ofSize: 12)
        }
    }
    
    @IBOutlet weak var parentView: UIView! {
        didSet {
            parentView.layer.borderColor = UIColor.gray.cgColor
            parentView.layer.borderWidth = 1
            parentView.layer.cornerRadius = 5
        }
    }
    
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(modal:FoodCellModal) {
        let image = modal.thumbnail.replacingOccurrences(of: " ", with: "%20")
        let url = URL(string: image)
        self.foodImage.kf.setImage(with: url)

        foodTitle.text = modal.title
        foodDuration.text = modal.duration
        foodDescription.text = modal.desc
        
    }
}
