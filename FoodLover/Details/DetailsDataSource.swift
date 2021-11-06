//
//  DetailsDataSource.swift
//  FoodLover
//
//  Created by Jhonny on 11/6/21.
//

import Foundation
import UIKit

enum DetailsCellType: Int, CaseIterable {
    case foodImage = 0
    case ingredients = 1
    case steps = 2
    var cellIdentifier: String {
        switch self {
        case .foodImage:
            return "DetailsImageCell"
        case .ingredients:
            return "DetailsIngredientCell"
        case .steps:
            return "DetailsStepsCell"
        }
    }
}

class DetailsDataSource: NSObject {
    
    private let details: DetailsModal
    private var celltype: [DetailsCellType]
    
    
    init(modal: DetailsModal, cellTypes: [DetailsCellType]) {
        self.details = modal
        self.celltype = cellTypes
    }
}

// MARK: - UITableViewDataSource methods
extension DetailsDataSource: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return celltype.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch celltype[section] {
        case .foodImage, .ingredients: return 1
        case .steps: return details.steps.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch celltype[indexPath.section] {
        case .ingredients: return createIngredientCell(tableView: tableView, indexPath: indexPath)
        case .steps: return createStepsCell(tableView: tableView, indexPath: indexPath)
        case .foodImage: return createFoodImageCell(tableView: tableView, indexPath: indexPath)
            
        }
    }
}

extension DetailsDataSource {
    
    func createStepsCell(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        let defaultCell = tableView.dequeueReusableCell(withIdentifier: DetailsCellType.steps.cellIdentifier,
                                                        for: indexPath)
        guard let cell = defaultCell as? DetailsStepsCell else {
            return defaultCell
        }
        let item = details.steps
        cell.configureUI(title: "Step \(indexPath.row + 1)", desc: item[indexPath.row])
        return cell
    }
    
    func createIngredientCell(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        let defaultCell = tableView.dequeueReusableCell(withIdentifier: DetailsCellType.ingredients.cellIdentifier,
                                                        for: indexPath)
        guard let cell = defaultCell as? DetailsIngredientCell else {
            return defaultCell
        }
        let item = details.ingredients
        cell.configureUI(title: "Ingredients", desc: item)
        return cell
    }
    
    func createFoodImageCell(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {

        let defaultCell = tableView.dequeueReusableCell(withIdentifier: DetailsCellType.foodImage.cellIdentifier,
                                                        for: indexPath)
        
        guard let cell = defaultCell as? DetailsImageCell else {
            return defaultCell
        }
        let item = details.thumbnail
        cell.configureUI(thumbnail: item)
        return cell
    }
    
}
