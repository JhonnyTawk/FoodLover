//
//  MainPresenter.swift
//  FoodLover
//
//  Created by Jhonny on 11/6/21.
//

import Foundation

protocol MainPresenterProtocol {
    var view: MainViewControllerProtocol? { get set}
    var interactor: MainInteractorInputProtocol? { get set}
    var router: MainRouterProtocol? { get set}
    
    func getListOfRecipes()
    func navigateToDetails(detailsModal: DetailsModal)
}

class MainPresenter: MainPresenterProtocol {
 
    var view:MainViewControllerProtocol?
    var interactor: MainInteractorInputProtocol?
    var router: MainRouterProtocol?
    
    func getListOfRecipes() {
        interactor?.fetchListOfReceips()
    }
    
    func navigateToDetails(detailsModal: DetailsModal) {
        router?.navigateToDetails(modal: detailsModal)
        
    }
}

extension MainPresenter: MainInteractorOutputProtocol {
    
    func receiveReceips(list: [AllFood]) {
        //Render UI
        view?.renderUI(list: list)
    }
}
