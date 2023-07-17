//
//  ItemDetailView.swift
//  MovieDB
//
//  Created by Sai Kumar Kasireddi on 12/07/23.
//

import SwiftUI

struct ItemDetailView: View {
    
    //MARK: Properties
    
    let item: String
    let itemMovies: [Movie]
    
    //MARK: Body
    
    var body: some View {
        VStack {
            List(itemMovies, id: \.self) { movie in
                NavigationLink(destination: {
                    MovieDetailView(movie: movie)
                }, label: {
                    Text(movie.title)
                })
            }
        }
        .navigationTitle(item.capitalized)
        .navigationBarTitleDisplayMode(.inline)
    }
}
