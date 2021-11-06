//
//  DetailsViewController.swift
//  FoodLover
//
//  Created by Jhonny on 11/6/21.
//

import Foundation
import UIKit

import GoogleMobileAds


class DetailsViewController: UIViewController {
    
    private var interstitial: GADInterstitialAd?

    var modal: DetailsModal?
    
    var dataSource: DetailsDataSource?
    
    //IBOutlets
    @IBOutlet weak var titleLabel: UILabel!
    
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel.text = modal?.title
        navigationController?.interactivePopGestureRecognizer?.delegate = nil
        
        renderUI()
        loadAd()
    }
    
    @IBAction func backAction(_ sender: Any) {
        
      if interstitial != nil {
          interstitial?.present(fromRootViewController: self)
       } else {
         print("Ad wasn't ready")
       }
    
    }
    
    func renderUI() {
        guard let modal = modal else {
            return
        }

        dataSource = DetailsDataSource(modal: modal,cellTypes: [.foodImage, .ingredients, .steps])
        
        tableView.dataSource = dataSource
        tableView.reloadData()
    }
    
    func loadAd() {
        let request = GADRequest()
        GADInterstitialAd.load(withAdUnitID:"ca-app-pub-3940256099942544/4411468910",
                               request: request,
                               completionHandler: { [self] ad, error in
            if let error = error {
                print("Failed to load interstitial ad with error: \(error.localizedDescription)")
                    return
            }
            interstitial = ad
            interstitial?.fullScreenContentDelegate = self
        })
    }
}

//Ads Delegate
extension DetailsViewController: GADFullScreenContentDelegate {
    
    /// Tells the delegate that the ad failed to present full screen content.
    func ad(_ ad: GADFullScreenPresentingAd, didFailToPresentFullScreenContentWithError error: Error) {
      print("Ad did fail to present full screen content.")
    }

    /// Tells the delegate that the ad presented full screen content.
    func adDidPresentFullScreenContent(_ ad: GADFullScreenPresentingAd) {
        self.navigationController?.popViewController(animated: true)
    }

    /// Tells the delegate that the ad dismissed full screen content.
    func adDidDismissFullScreenContent(_ ad: GADFullScreenPresentingAd) {
      print("Ad did dismiss full screen content.")
    }
}

