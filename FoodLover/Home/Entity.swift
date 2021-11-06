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

struct MainObjetModal: Codable {
    let allFoods: [AllFood]

    enum CodingKeys: String, CodingKey {
        case allFoods = "AllFoods"
    }
}

// MARK: - AllFood
struct AllFood: Codable {
    let categoryName: String
    let receipes: [Receipe]
}

// MARK: - Receipe
struct Receipe: Codable {
    let name: String
    let imageurl: String
    let timetoprepare, smalldescription: String
    let ingredients, steps: [String]
}
