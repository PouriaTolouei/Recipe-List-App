//
//  DataService.swift
//  Recipe List App
//
//  Created by Pouria Tolouei on 26/06/2022.
//

import Foundation

class DataService {
    
    static func getLocalData() -> [Recipe] {
        
        // Parse local json file
        
        // Get a url path to  json file
        let pathString = Bundle.main.path(forResource: "recipes", ofType: "json")
        
        // Check if pathString is not nil, otherwise...
        guard pathString != nil else {
            return [Recipe]()
        }
        
        do {
            // Create a url and data object to fetch the data
            let data = try Data(contentsOf: URL(fileURLWithPath: pathString!))
            
            do {
                // Decode the data using JSON decoder
                let recipeData =  try JSONDecoder().decode([Recipe].self, from: data)
                
                // Add the unique ID
                for recipe in recipeData  {
                    recipe.id = UUID()
                }
                
                // Return the recipes
                return recipeData
            }
            catch {
                // Error with decoding JSON
                print(error)
            }
        }
        catch {
            // Error with getting data
            print(error)
        }
        
        // In case the parsing of the JSON fails
        return [Recipe]()
    }
}
