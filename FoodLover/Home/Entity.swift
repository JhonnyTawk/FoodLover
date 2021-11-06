//
//  Entity.swift
//  FoodLover
//
//  Created by Jhonny on 11/6/21.
//

import Foundation

enum Entity {
    case listRecipes
}

extension Entity: Request {
    var path: String {
        return API.host
    }
}
