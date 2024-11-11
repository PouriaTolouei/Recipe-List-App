//
//  RecipeFeaturedView.swift
//  Recipe List App
//
//  Created by Pouria Tolouei on 05/07/2022.
//

import SwiftUI

struct RecipeFeaturedView: View {
    
    @EnvironmentObject var model: RecipeModel
    @State var isDetailViewShowing = false
    @State var tabSelectionIndex = 0
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 0) {
            
            Text("Featured Recipes")
                .bold()
                .padding(.leading)
                .padding(.top, 40)
                .font(Font.custom("Avenir Heavy" , size: 24))
                
            GeometryReader { geo in
                
                TabView(selection: $tabSelectionIndex) {
                    
                    // Loops through each recipe
                    ForEach(0..<model.recipes.count, id: \.self) { i in
                        
                        // Only show those that should be featured
                        if model.recipes[i].featured {
                            
                            // Recipe card button
                            Button {
                                
                                // Show the recipe detail sheet
                                self.isDetailViewShowing = true
                                
                            } label: {
                                
                                // Recipe card
                                ZStack {
                                    Rectangle()
                                        .foregroundColor(.white)
                                        
                                    VStack(spacing: 0) {
                                        Image(model.recipes[i].image)
                                            .resizable()
                                            .aspectRatio(contentMode: .fill)
                                            .clipped()
                                        Text(model.recipes[i].name)
                                            .padding(5)
                                            .font(Font.custom("Avenir" , size: 15))
                                    }
                                }
                            }
                            .tag(i)
                            .buttonStyle(PlainButtonStyle())
                            .frame(width: geo.size.width - 40, height: geo.size.height - 100, alignment: .center)
                            .cornerRadius(15)
                            .shadow(color: Color(.sRGB, red: 0 , green: 0, blue: 0, opacity: 0.5) , radius: 10, x: -5, y: 5)
                        }
                    }
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
                .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
                .sheet(isPresented: $isDetailViewShowing) {
                    
                    // Show the recipe DetailView
                    RecipeDetailView(recipe: model.recipes[tabSelectionIndex])
                }
            }
            
            VStack(alignment: .leading, spacing: 10) {
                Text("Preperation Time:")
                    .font(Font.custom("Avenir Heavy" , size: 16))
                Text(model.recipes[tabSelectionIndex].prepTime)
                    .font(Font.custom("Avenir" , size: 15))
                Text("Highlights:")
                    .font(Font.custom("Avenir Heavy" , size: 16))
                RecipeHighlights(highlights: model.recipes[tabSelectionIndex].highlights)
            }
            .padding([.leading, .bottom])
        }
        .onAppear {
            setFeaturedIndex()
        }
    }
    
    func setFeaturedIndex() {
        
        // Find the index of first recipe that's featured
        let index = model.recipes.firstIndex { recipe in
            return recipe.featured
        }
        
        tabSelectionIndex = index ?? 0
    }
}
 
struct RecipeFeaturedView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeFeaturedView()
            .environmentObject(RecipeModel())
    }
}
