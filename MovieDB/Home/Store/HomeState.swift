//
//  HomeState.swift
//  MovieDB
//
//  Created by Sai Kumar Kasireddi on 17/07/23.
//

import Foundation

struct HomeState: StateRepresentable {
    
    var movies: [Movie] = []
    var searchResults: [Movie] = []
    var homeViewOptions: HomeViewOptions = HomeViewOptions()
}
