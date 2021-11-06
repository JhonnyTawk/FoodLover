//
//  DataManager.swift
//  FoodLover
//
//  Created by Jhonny on 11/6/21.
//

import Foundation

typealias SuccessHandler = (([AllFood]) -> Void)
typealias ErrorHandler = ((APIError) -> Void)

protocol dataManagerDelegate {
    func getAllrecipes(successCompletion: @escaping SuccessHandler, errorCompletion: @escaping ErrorHandler)
}

enum APIError: Error {
    case unexpectedError
    case serializeError
}

class DataManager: dataManagerDelegate {

    func getAllrecipes(successCompletion: @escaping SuccessHandler, errorCompletion: @escaping ErrorHandler) {
        let modifiers = Entity.listRecipes.build()
        let service = NetworkService(modifiers: modifiers)
        service.getRequest { (result) in
            switch result {
            case .failure:
                errorCompletion(APIError.unexpectedError)
            case .success(let data):
                do {
                    let modal = try JSONDecoder().decode(MainObjetModal.self, from: data)
                    successCompletion(modal.allFoods)
                }catch {
                    errorCompletion(APIError.serializeError)
                }
            }
        }
    }
}
