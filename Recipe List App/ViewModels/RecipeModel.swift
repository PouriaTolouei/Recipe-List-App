//
//  RecipeModel.swift
//  Recipe List App
//
//  Created by Pouria Tolouei on 26/06/2022.
//

import Foundation

class RecipeModel: ObservableObject {
    @Published var recipes = [Recipe]()
    @Published var categories = Set<String>()
    @Published var selectedCategory: String?
    
    init() {
        // Create an instance of DataService and get the data
        self.recipes = DataService.getLocalData()
        
        // Adds an array of category Strings (excluding duplicates) to the categories set
        self.categories = Set(self.recipes.map { r in
            return r.category
        })
        
        // Adds an additional catgeory for all recipes
        self.categories.update(with: Constants.defaultListFilter)
    }
    
    static  func getPortion(ingredient: Ingredient, recipeServings: Int, targetServings: Int) -> String {
        
        var portion = ""
        var numerator = ingredient.num ?? 1
        var denominator = ingredient.denom ?? 1
        var wholePortions = 0
        
        if ingredient.num != nil {
            // Get a single serving size by multiplying denominator by the recipe servings
            denominator *= recipeServings
            
            // Get target portion by multiplying denominator by the target servings
            numerator *= targetServings
        
            // Reduce fraction by greatest common divisor
            let divisor = Rational.greatestCommonDivisor(numerator, denominator)
            numerator /= divisor
            denominator /= divisor
            
            // Get the whole portion if numerator > denominator
            if numerator >= denominator {
                
                // Calculate whole portions
                wholePortions = numerator / denominator
                
                // Calculate the remainder
                numerator =   numerator % denominator
                
                // Assign to portion string
                portion += String(wholePortions)
            }
            
            // Express the remainder as a fraction
            if numerator > 0 {
                
                // Assign remainder as a fraction to the portion string
                portion += wholePortions > 0 ? " " : ""
                portion += "\(numerator)/\(denominator)"
            }
            
        }
        
        if var unit = ingredient.unit {
            
            // If we need to pluralize
            if wholePortions > 1 {
                
                // Calculate appropriate suffix
                if unit.suffix(2) == "ch" {
                    unit += "es"
                }
                else if unit.suffix(1) == "f" {
                    unit = String(unit.dropLast( ))
                    unit += "ves"
                }
                else {
                    unit += "s"
                }
                                
            }
            
            // Calculate appropriate space
            portion += ingredient.num == nil && ingredient.denom == nil ? "" : " "
            
            return portion + unit
            
        }
            
         
        
        return portion
    
        
    }
}
