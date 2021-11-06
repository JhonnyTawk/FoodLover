//
//  MainViewController.swift
//  FoodLover
//
//  Created by Jhonny on 11/6/21.
//

import Foundation
import UIKit

protocol MainViewControllerProtocol {
    
    var presenter: MainPresenterProtocol? { get set }
    
    func hideLoading()
    func showLoading()
    func renderUI(list: [AllFood])
}

class MainViewController: UIViewController {
    
    // vars
    var presenter: MainPresenterProtocol?
    
    //Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.getListOfRecipes()
    }
}

extension MainViewController: MainViewControllerProtocol {
   
    
    func hideLoading() {
        //later
    }
    
    func showLoading() {
        //later
    }
    
    func renderUI(list: [AllFood]) {
        //Load table And display Data
    }
}
