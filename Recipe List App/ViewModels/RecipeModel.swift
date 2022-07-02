//
//  RecipeModel.swift
//  Recipe List App
//
//  Created by Pouria Tolouei on 26/06/2022.
//

import Foundation

class RecipeModel: ObservableObject {
    @Published var recipes = [Recipe]()
    
    init() {
        // Create an instance of DataService and get the data
        self.recipes = DataService.getLocalData()
    }
}
