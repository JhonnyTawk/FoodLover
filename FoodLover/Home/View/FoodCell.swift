//
//  FoodCell.swift
//  FoodLover
//
//  Created by Jhonny on 11/6/21.
//

import Foundation
import UIKit
import Kingfisher

struct FoodCellModal {
    var thumbnail: String
    var title: String
    var desc: String
    var duration: String
}

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
    
    func configure(modal:FoodCellModal) {
        foodImage.kf.setImage(with: URL(string: modal.thumbnail))
        foodTitle.text = modal.title
        foodDuration.text = modal.duration
        foodDescription.text = modal.desc
        
    }
}
