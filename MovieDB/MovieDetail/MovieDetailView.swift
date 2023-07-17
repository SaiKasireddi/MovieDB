//
//  MovieDetailView.swift
//  MovieDB
//
//  Created by Sai Kumar Kasireddi on 12/07/23.
//

import SwiftUI

struct MovieDetailView: View {
    
    //MARK: Properties
    
    let movie: Movie
    
    @State private var showChooseRatingSource: Bool = false
    @State private var rating: Rating = Rating(source: "", value: "")
    private let paddingValue: CGFloat = 8
    
    @State var selection: String = "Most Recent"
    let filterOptions: [String] = ["Most Recent", "Most Papular", "Most Liked"]

    //MARK: Body
    
    var body: some View {
        ScrollView(.vertical) {
            posterImage
            movieDetails
            if showChooseRatingSource {
                chooseRatingSource
            }
        }
        .padding(paddingValue)
        .navigationTitle(movie.title)
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            if let firstRating = movie.ratings.first {
                rating = firstRating
                showChooseRatingSource = true
            }
        }
    }
    
    //MARK: SubViews
    
    private var posterImage: some View {
        AsyncImage(url: URL(string: movie.poster)) { image in
            image
                .resizable()
                .frame(width: UIScreen.main.bounds.width/2,
                       height: UIScreen.main.bounds.height/3)
                .scaledToFit()
                .border(Color.primary)
                .padding(paddingValue)
        } placeholder: {
            ProgressView(label: {
                Text("loading.image".localised)
            })
        }
    }
    
    private var movieDetails: some View {
        VStack(alignment: .leading, spacing: paddingValue) {
            Text("__Title:__ \(movie.title)")
            Text("__Plot:__ \(movie.plot)")
            Text("__Cast & Crew:__ \(movie.actors)")
            Text("__Released Date:__ \(movie.released)")
            Text("__Genre:__ \(movie.genres)")
        }
    }
    
    private var chooseRatingSource: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack {
                Text("__Please choose a Rating Source__")
                Spacer()
            }
                
            HStack {
                Picker("Please choose a Rating Source", selection: $rating) {
                    ForEach(movie.ratings, id: \.self) { rating in
                        Text(rating.source)
                    }
                }
                .pickerStyle(.menu)
                Spacer()
                Text(rating.value)
                    .padding(.trailing)
            }
        }
        .frame(maxWidth: .infinity)
        .padding(.top, 2)
    }
}
