//
//  MainViewController.swift
//  FoodLover
//
//  Created by Jhonny on 11/6/21.
//

import Foundation
import UIKit
import GoogleMobileAds

protocol MainViewControllerProtocol {
    
    var presenter: MainPresenterProtocol? { get set }
    func renderUI(list: [AllFood])
}

class MainViewController: UIViewController {
    
    // vars
    var presenter: MainPresenterProtocol?
    
    @IBOutlet weak var removeButton: UIButton!
    @IBOutlet weak var bottomCollectionConstraints: NSLayoutConstraint!
    var foodList = [AllFood]() {
        didSet {
            DispatchQueue.main.async { [weak self] in
                self?.collectionView.reloadData()
            }
        }
    }
    
    //IBOutlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var bannerView: GADBannerView!
    
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            self.collectionView.delegate = self
            self.collectionView.dataSource = self
            let nibName = UINib(nibName: String(describing: FoodCell.self), bundle: nil)
            collectionView.register(nibName, forCellWithReuseIdentifier: "FoodCell")
            collectionView.register(SectionHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "header")
            collectionView.backgroundColor = .white
        }
    }
    
    //Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = "Food Lovers"
        presenter?.getListOfRecipes()
        setupBanner()
    }
    
    func setupBanner() {
        bannerView.adUnitID = "ca-app-pub-3940256099942544/2934735716"
        bannerView.rootViewController = self
        bannerView.load(GADRequest())
        bannerView.delegate = self
    }
    
    @IBAction func removeAd(_ sender: Any) {
        showAlert()
    }
    func hideAds() {
        //Remove Banner
        bannerView.removeFromSuperview()
        //Remove Button
        removeButton.removeFromSuperview()
        //Adjust Constraint
        bottomCollectionConstraints.constant = 0
        
    }
    
    func showAlert() {
        
        let alert = UIAlertController(title: "Remove Ads", message: "pay 2.99$ to remove the ads", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { [weak self] action in
            self?.hideAds()
        }))
        alert.addAction(UIAlertAction(title: "No", style: .default, handler: { action in
            
        }))
        self.present(alert, animated: true, completion: nil)
    }
}

extension MainViewController: MainViewControllerProtocol {
    func renderUI(list: [AllFood]) {
        //Load table And display Data
        foodList = list
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
        cell.configure(modal: modal)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let allFoods = foodList[indexPath.section]
        let item = allFoods.receipes[indexPath.item]
        let modal = DetailsModal(thumbnail: item.imageurl,
                                 title: item.name,
                                 steps: item.steps,
                                 ingredients: item.ingredients)
        presenter?.navigateToDetails(detailsModal: modal)
    }
}

extension MainViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let cellWidth = FoodCellConstants().cellWidth()
        return CGSize(width: CGFloat(cellWidth), height: CGFloat(cellWidth + 20))

    }
    
    func collectionView(_: UICollectionView, layout _: UICollectionViewLayout, minimumLineSpacingForSectionAt _: Int) -> CGFloat {
        return FoodCellConstants().spaceBetweenItems
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return FoodCellConstants().spaceBetweenItems
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: FoodCellConstants().sectionInset, bottom: 0, right: FoodCellConstants().sectionInset)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
          
        let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "header", for: indexPath) as? SectionHeader ?? SectionHeader()
        
        let items = foodList[indexPath.section]
        let header = items.categoryName
        sectionHeader.label.text = header
        
        return sectionHeader

    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 20)
    }
}

//Ads
extension MainViewController: GADBannerViewDelegate {
    func bannerViewDidReceiveAd(_ bannerView: GADBannerView) {
      print("bannerViewDidReceiveAd")
    }

    func bannerView(_ bannerView: GADBannerView, didFailToReceiveAdWithError error: Error) {
      print("bannerView:didFailToReceiveAdWithError: \(error.localizedDescription)")
    }

    func bannerViewDidRecordImpression(_ bannerView: GADBannerView) {
      print("bannerViewDidRecordImpression")
    }

    func bannerViewWillPresentScreen(_ bannerView: GADBannerView) {
      print("bannerViewWillPresentScreen")
    }

    func bannerViewWillDismissScreen(_ bannerView: GADBannerView) {
      print("bannerViewWillDIsmissScreen")
    }

    func bannerViewDidDismissScreen(_ bannerView: GADBannerView) {
      print("bannerViewDidDismissScreen")
    }
}
