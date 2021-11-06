//
//  DataManager.swift
//  FoodLover
//
//  Created by Jhonny on 11/6/21.
//

import Foundation

protocol dataManagerDelegate {
    func getAllrecipes()
}


class DataManager: dataManagerDelegate {
    
    
    func getAllrecipes() {
        let modifiers = Entity.listRecipes.build()
        print(modifiers)
        let service = NetworkService(modifiers: modifiers)
        service.getRequest { (result) in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let data):
                print(String(data: data, encoding: .utf8))
            }
        }
    }
}
