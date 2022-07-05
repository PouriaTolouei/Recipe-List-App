//
//  RecipeListView.swift
//  Recipe List App
//
//  Created by Pouria Tolouei on 26/06/2022.
//

import SwiftUI

struct RecipeListView: View {
    
    @EnvironmentObject var model: RecipeModel
    
    var body: some View {
        NavigationView {
            List(model.recipes) { r in
                
                NavigationLink {
                    RecipeDetailView(recipe: r)
                } label: {
                    HStack(spacing: 20.0) {
                        Image(r.image)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 50, height: 50, alignment: .center)
                            //.clipped()
                            .cornerRadius(5)
                            
                        Text(r.name)
                    }
                }
            }
            .navigationTitle("All Recipes")
        }
        .navigationViewStyle(.stack)
    }
}

struct RecipeListView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeListView()
    }
}
