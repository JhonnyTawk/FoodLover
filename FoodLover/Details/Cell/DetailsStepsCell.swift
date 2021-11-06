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
    
    func configureUI(title: String, desc: [String]) {
        
        titleLabel.text = title
        titleLabel.font = UIFont.systemFont(ofSize: 14, weight: .bold)

        let finalStr = "- " + desc.joined(separator: "\n- ")
        descLabel1.text = finalStr
        descLabel1.numberOfLines = 0
        descLabel1.font = UIFont.systemFont(ofSize: 12, weight: .regular)
    }
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
        descLabel1.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        
        descLabel2.text = desc
        descLabel2.font = UIFont.systemFont(ofSize: 12, weight: .regular)
    }
    
}
