//
//  MainInteractor.swift
//  FoodLover
//
//  Created by Jhonny on 11/6/21.
//

import Foundation

protocol MainInteractorOutputProtocol {
    func receiveReceips(list: [AllFood])
}
    
protocol MainInteractorInputProtocol {
    var presenterOutput: MainInteractorOutputProtocol? { get set }
    var dataManager: dataManagerProtocol? { get set }
    
    func fetchListOfReceips()
}
    
class MainInteractor: MainInteractorInputProtocol {
    
    var presenterOutput: MainInteractorOutputProtocol?
    var dataManager: dataManagerProtocol?
    
    func fetchListOfReceips() {
        dataManager?.getAllrecipes(successCompletion: { allFood in
            //Success
            self.presenterOutput?.receiveReceips(list: allFood)
        }, errorCompletion: { error in
            //TODO: handler Error
            print(error)
        })
    }
    
}
