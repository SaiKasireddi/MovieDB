//
//  HomeView.swift
//  MovieDB
//
//  Created by Sai Kumar Kasireddi on 12/07/23.
//

import SwiftUI

struct HomeView: View {
    
    //MARK: Properties
    
    @StateObject var homeStore: HomeStore = HomeStore()
    @State private var searchText: String = ""

    //MARK: Body
    
    var body: some View {
        NavigationView {
            VStack {
                if homeStore.state.searchResults.isEmpty  {
                    optionsList
                } else {
                    movieList
                }
            }
            .navigationTitle(Constants.homeViewTitle)
            .navigationBarTitleDisplayMode(.inline)
            .onAppear {
                homeStore.send(.onAppear)
            }
            .searchable(text: $searchText)
            .onChange(of: searchText, perform: { _ in
                homeStore.send(.clickedOnSearchButton(searchText: searchText))
            })
        }
    }
    
    //MARK: SubViews
    
    private var movieList: some View {
        List(homeStore.state.searchResults, id: \.self) { movie in
            NavigationLink(destination: {
                MovieDetailView(movie: movie)
            }, label: {
                Text(String(describing: movie.title))
            })
        }
    }
    
    private var optionsList: some View {
        List(HomeStore.HomeViewCases.allCases, id: \.self) { option in
            NavigationLink(destination: {
                FirstDetailView(movies: homeStore.state.movies, optionCase: option, items: homeStore.getItemsArray(for: option))
            }, label: {
                Text(String(describing: option.rawValue.capitalized))
            })
        }
    }
}

//MARK: Previews

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
