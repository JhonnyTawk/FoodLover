//
//  DetailsViewController.swift
//  FoodLover
//
//  Created by Jhonny on 11/6/21.
//

import Foundation
import UIKit


class DetailsViewController: UIViewController {
    
    var modal: DetailsModal?
    
    var dataSource: DetailsDataSource?
    
    //IBOutlets
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            let nibName = UINib(nibName: String(describing: DetailsStepsCell.self), bundle: nil)
            tableView.register(nibName, forCellReuseIdentifier: DetailsCellType.steps.cellIdentifier)
            
            let detailsNib = UINib(nibName: String(describing: DetailsIngredientCell.self), bundle: nil)
            tableView.register(detailsNib, forCellReuseIdentifier: DetailsCellType.ingredients.cellIdentifier)
            tableView.separatorStyle = .none
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.interactivePopGestureRecognizer?.delegate = nil
        
        renderUI()
    }
    
    func renderUI() {
        guard let modal = modal else {
            return
        }

        dataSource = DetailsDataSource(modal: modal,cellTypes: [.ingredients, .steps])
        
        tableView.dataSource = dataSource
//        tableView.delegate = dataSource
        tableView.reloadData()
    }
}
