//
//  Ingredient.swift
//  Recipe List App
//
//  Created by Pouria Tolouei on 03/07/2022.
//

import Foundation

class Ingredient: Identifiable, Decodable {
    var id: UUID?
    var name: String
    var num: Int?
    var denom: Int?
    var unit: String?
    
}
