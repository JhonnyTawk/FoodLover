//
//  DetailsDataSource.swift
//  FoodLover
//
//  Created by Jhonny on 11/6/21.
//

import Foundation
import UIKit

enum DetailsCellType: Int, CaseIterable {
    case ingredients = 0
    case steps = 1
    var cellIdentifier: String {
        switch self {
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
//        if celltype == .ingredients {
//            return 1
//        }else {
            return details.steps.count
//        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        switch celltype {
//        case .ingredients: return createStepsCell(tableView: tableView, indexPath: indexPath)
//        case .steps: return createStepsCell(tableView: tableView, indexPath: indexPath)
//        }
        return createStepsCell(tableView: tableView, indexPath: indexPath)
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
    
}