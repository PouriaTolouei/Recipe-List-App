//
//  RecipeListView.swift
//  Recipe List App
//
//  Created by Pouria Tolouei on 26/06/2022.
//

import SwiftUI

struct RecipeListView: View {
    
    @EnvironmentObject var model: RecipeModel
    
    private var title: String {
        
        if model.selectedCategory == nil || model.selectedCategory == Constants.defaultListFilter {
            return "All Recipes"
        }
        else {
            return "\(model.selectedCategory!) Recipes"
        }
    }
    
    var body: some View {
        NavigationView {
            
            VStack(alignment: .leading) {
                
                HStack {
                    
                    Text(title)
                        .bold()
                        .font(Font.custom("Avenir Heavy" , size: 24))
                    
                    Spacer()
                    
                    Button {
                        model.selectedCategory = Constants.defaultListFilter
                    } label: {
                        
                        Text("Reset Category")
                            .foregroundColor(.black)
                            .font(Font.custom("Avenir" , size: 15))
                    }
                }
                .padding(.top, 40)
                    
                ScrollView {
                    
                    LazyVStack(alignment: .leading) {
                        
                        ForEach(model.recipes) { r in
                            
                            if model.selectedCategory == nil ||
                                model.selectedCategory == Constants.defaultListFilter ||
                                model.selectedCategory != nil && r.category == model.selectedCategory {
                                
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
                                                .font(Font.custom("Avenir Heavy" , size: 16))
                                            
                                            RecipeHighlights(highlights: r.highlights)
                                            
                                        }
                                        .foregroundColor(.black)
                                    }
                                }
                            }
                        }
                    }
                }
                
            }
            .navigationBarHidden(true)
            .padding(.horizontal)
        }
        
    }
}

struct RecipeListView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeListView()
            .environmentObject(RecipeModel())
    }
}
