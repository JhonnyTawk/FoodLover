//
//  FoodCell.swift
//  FoodLover
//
//  Created by Jhonny on 11/6/21.
//

import Foundation
import UIKit

struct FoodCellModal {
    var thumbnail: String
    var title: String
    var desc: String
    var duration: String
}

class FoodCell: UICollectionViewCell {
    
    @IBOutlet weak var foodImage: UIImageView!
    @IBOutlet weak var foodTitle: UILabel!
    @IBOutlet weak var foodDuration: UILabel!
    @IBOutlet weak var foodDescription: UILabel!
    
    func configure(modal:FoodCellModal) {
        
    }
}
