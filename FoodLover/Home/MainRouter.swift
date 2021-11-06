//
//  MainRouter.swift
//  FoodLover
//
//  Created by Jhonny on 11/6/21.
//

import Foundation
import UIKit

protocol MainRouterProtocol {
    
    var controller: MainViewController? { get set }
    
    static func createMainModule() -> MainViewController
    func navigateToDetails(modal: DetailsModal)
}

class MainRouter: MainRouterProtocol {
    
     var controller: MainViewController?
    
    static func createMainModule() -> MainViewController {
        let instance: MainViewController = MainViewController()
        var presenter: MainPresenterProtocol & MainInteractorOutputProtocol = MainPresenter()
        var interactor: MainInteractorInputProtocol = MainInteractor()
        let dataManager: dataManagerProtocol = DataManager()
        var router: MainRouterProtocol = MainRouter()
        
        instance.presenter = presenter
        presenter.view = instance
        presenter.interactor = interactor
        presenter.router = router
        interactor.presenterOutput = presenter
        interactor.dataManager = dataManager
        router.controller = instance
        return instance
        
    }
    
    func navigateToDetails(modal: DetailsModal) {
       let instance = DetailsViewController()
        instance.modal = modal
        controller?.navigationController?.pushViewController(instance, animated: true)
    }    
}
