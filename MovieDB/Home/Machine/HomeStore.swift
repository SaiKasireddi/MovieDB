//
//  HomeStore.swift
//  MovieDB
//
//  Created by Sai Kumar Kasireddi on 17/07/23.
//

import Foundation

final class HomeStore: Store, ObservableObject {
    
    @Published private(set) var state: HomeState = HomeState()
        
    //MARK: Methods

    @MainActor func reduce(from action: HomeAction) -> HomeAction? {
        switch action {
        case .onAppear:
            self.getData()
            
        case .clickedOnSearchButton(let searchString):
            self.searchMovies(with: searchString)
        }
        return nil
    }
    
    /// This method fetches data & assigns values to state.homeViewOptions
    func getData() {
        if let movies = MoviesModel.fetchMovies() {
            state.movies = movies
            addDataToHomeViewOptions()
        }
    }
    
    /// This method assigns values to state.homeViewOptions
    func addDataToHomeViewOptions() {
        for movie in state.movies {
            // Year
            state.homeViewOptions.years.insert(movie.year)
            // Genre
            let genres: [String] = movie.genres.components(separatedBy: ",")
            for genre in genres {
                state.homeViewOptions.genres.insert(genre.trimmingCharacters(in: .whitespacesAndNewlines))
            }
            // Directors
            let directors: [String] = movie.directors.components(separatedBy: ",")
            for director in directors {
                state.homeViewOptions.directors.insert(director.trimmingCharacters(in: .whitespacesAndNewlines))
            }
            // Actors
            let actors: [String] = movie.actors.components(separatedBy: ",")
            for actor in actors {
                state.homeViewOptions.actors.insert(actor.trimmingCharacters(in: .whitespacesAndNewlines))
            }
            // All Movies
            state.homeViewOptions.allMovies.insert(movie.title)
        }
    }
    
    func searchMovies(with searchString: String) {
        state.searchResults = MoviesModel.searchMovies(with: searchString.capitalized, from: state.movies)
    }
    
    /// This method returns Array of homeViewOptions properties
    func getItemsArray(for homeViewOptionsEnumCase: HomeViewCases) -> [String] {
        switch homeViewOptionsEnumCase {
        case .actors:
            return Array(state.homeViewOptions.actors)
        case .directors:
            return Array(state.homeViewOptions.directors)
        case .genres:
            return Array(state.homeViewOptions.genres)
        case .years:
            return Array(state.homeViewOptions.years)
        case .allMovies:
            return Array(state.homeViewOptions.allMovies)
        }
    }
    
    //MARK: Enum For Home View Options
    
    enum HomeViewCases: String, CaseIterable {
        
        case years
        case genres
        case directors
        case actors
        case allMovies = "All Movies"
    }
}
