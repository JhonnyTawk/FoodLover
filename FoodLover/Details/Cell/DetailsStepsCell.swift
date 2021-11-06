//
//  DetailsCell.swift
//  FoodLover
//
//  Created by Jhonny on 11/6/21.
//

import Foundation
import UIKit

class DetailsIngredientCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descLabel1: UILabel!
}

class DetailsStepsCell: UITableViewCell {
    @IBOutlet weak var descLabel1: UILabel!
    @IBOutlet weak var descLabel2: UILabel! {
        didSet {
            descLabel2.numberOfLines = 0
        }
        
    }
    
    
    func configureUI(title: String, desc: String) {
        descLabel1.text = title
        descLabel2.text = desc
    }
    
}
