//
//  FirstDetailView.swift
//  MovieDB
//
//  Created by Sai Kumar Kasireddi on 12/07/23.
//

import SwiftUI

struct FirstDetailView: View {
    
    //MARK: Properties
    
    let movies: [Movie]
    let optionCase: HomeStore.HomeViewCases
    let items: [String]
        
    //MARK: Body
    
    var body: some View {
        VStack {
            List(items, id: \.self) { item in
                NavigationLink(destination: {
                    ItemDetailView(item: item, itemMovies: getMovies(with: item))
                }, label: {
                    Text(item)
                })
            }
        }
        .navigationTitle(optionCase.rawValue.capitalized)
        .navigationBarTitleDisplayMode(.inline)
    }
    
    //MARK: Methods
    
    /// This method fetches movies for given item
    func getMovies(with item: String) -> [Movie] {
        MoviesModel.getMovies(for: item, with: optionCase, from: movies)
    }
}
