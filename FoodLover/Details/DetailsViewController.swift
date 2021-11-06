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
            //Steps cell
            let stepsNib = UINib(nibName: String(describing: DetailsStepsCell.self), bundle: nil)
            tableView.register(stepsNib, forCellReuseIdentifier: DetailsCellType.steps.cellIdentifier)
            
            //details cell
            let detailsNib = UINib(nibName: String(describing: DetailsIngredientCell.self), bundle: nil)
            tableView.register(detailsNib, forCellReuseIdentifier: DetailsCellType.ingredients.cellIdentifier)
            
            //image cell
            let imageNib = UINib(nibName: String(describing: DetailsImageCell.self), bundle: nil)
            tableView.register(imageNib, forCellReuseIdentifier: DetailsCellType.foodImage.cellIdentifier)
            
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

        dataSource = DetailsDataSource(modal: modal,cellTypes: [.foodImage, .ingredients, .steps])
        
        tableView.dataSource = dataSource
        tableView.reloadData()
    }
}
