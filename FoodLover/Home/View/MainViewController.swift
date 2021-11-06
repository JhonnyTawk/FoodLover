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
    
    var foodList = [AllFood]()
    
    //IBOutlets
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            self.collectionView.delegate = self
            self.collectionView.dataSource = self
            let nibName = UINib(nibName: String(describing: FoodCell.self), bundle: nil)
            collectionView.register(nibName, forCellWithReuseIdentifier: "FoodCell")
            collectionView.backgroundColor = .white
        }
    }
    
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
        foodList = list
        DispatchQueue.main.async { [weak self] in
            self?.collectionView.reloadData()
        }
        
    }
}

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
 
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return foodList[section].receipes.count
    }
   
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return foodList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let initialCell = collectionView.dequeueReusableCell(withReuseIdentifier: "FoodCell", for: indexPath)
        guard let cell = initialCell as? FoodCell else {
            return initialCell
        }
        
        let allFoods = foodList[indexPath.section]
        let item = allFoods.receipes[indexPath.item]
        
        let modal = FoodCellModal(thumbnail: item.imageurl,
                                  title: item.name,
                                  desc: item.smalldescription,
                                  duration: item.timetoprepare)
        print(modal)
        return cell
    }
    
    
}
