//
//  Constants.swift
//  FoodLover
//
//  Created by Jhonny on 11/6/21.
//
import Foundation
import UIKit

struct API {
   static let host = "http://testtask.solidtechapps.com/api/v1/response/"
}

struct FoodCellConstants {
    
    private let numberOfItemsRow : CGFloat = 2
    let spaceBetweenItems : CGFloat = 8
    let sectionInset : CGFloat = 15

    func cellWidth() -> CGFloat {
        let screenWidth = UIScreen.main.bounds.width
        let collectionViewWidthWithoutInsets = screenWidth - (sectionInset * 2)
        let spaceBetweenItemsValue = spaceBetweenItems * (numberOfItemsRow - 1)
        let width: CGFloat = (collectionViewWidthWithoutInsets - spaceBetweenItemsValue) / numberOfItemsRow
        return width
    }
}
