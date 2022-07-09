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
            
            VStack(alignment: .leading) {
                
                Text("All Recipes")
                    .bold()
                    .padding(.top, 40)
                    .font(.largeTitle)
                
                ScrollView {
                    
                    LazyVStack(alignment: .leading) {
                        
                        ForEach(model.recipes) { r in
                            
                            NavigationLink {
                                RecipeDetailView(recipe: r)
                            } label: {
                                
                                // MARK: Row Item
                                HStack(spacing: 20.0) {
                                    
                                    Image(r.image)
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 50, height: 50, alignment: .center)
                                        .cornerRadius(5)
                                        
                                    VStack(alignment: .leading) {
                                        Text(r.name)
                                            .bold()
                                        
                                        RecipeHighlights(highlights: r.highlights)
                                            .font(.footnote)
                                    }
                                    .foregroundColor(.black)
                                }
                            }
                        }
                    }
                }
                
            }
            .navigationBarHidden(true)
            .padding(.leading)
        }
        
    }
}

struct RecipeListView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeListView()
            .environmentObject(RecipeModel())
    }
}
