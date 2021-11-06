//
//  MainRouter.swift
//  FoodLover
//
//  Created by Jhonny on 11/6/21.
//

import Foundation

protocol MainRouterProtocol {
    static func createMainModule() -> MainViewController
}

class MainRouter: MainRouterProtocol {
    
    static func createMainModule() -> MainViewController {
        let instance: MainViewController = MainViewController()
        var presenter: MainPresenterProtocol & MainInteractorOutputProtocol = MainPresenter()
        var interactor: MainInteractorInputProtocol = MainInteractor()
        let dataManager: dataManagerProtocol = DataManager()
        let router: MainRouterProtocol = MainRouter()
        
        instance.presenter = presenter
        presenter.view = instance
        presenter.interactor = interactor
        presenter.router = router
        interactor.presenterOutput = presenter
        interactor.dataManager = dataManager
        return instance
        
    }
    
}
