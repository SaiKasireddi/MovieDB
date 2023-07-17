//
//  MovieModel.swift
//  MovieDB
//
//  Created by Sai Kumar Kasireddi on 12/07/23.
//

import Foundation


struct MoviesModel {

    //MARK: Methods
    
    /// This method fetch for given "item" with given "optionCase" from given "movies"
    static func getMovies(for item: String, with optionCase: HomeStore.HomeViewCases, from movies: [Movie]) -> [Movie] {
        switch optionCase {
        case .actors:
            return movies.filter { movie in
                movie.actors.contains(item)
            }
        case .genres:
            return movies.filter { movie in
                movie.genres.contains(item)
            }
        case .years:
            return movies.filter { movie in
                movie.year.contains(item)
            }
        case .directors:
            return movies.filter { movie in
                movie.directors.contains(item)
            }
        case .allMovies:
            return movies.filter { movie in
                movie.title.contains(item)
            }
        }
    }
    
    /// This method search movies for given "searchText", from given "movies"
    static func searchMovies(with searchText: String, from movies: [Movie]) -> [Movie] {
        var results: Set<Movie> = []
        
        results.formUnion(movies.filter { movie in
                            movie.actors.contains(searchText)
                        })
        results.formUnion( movies.filter { movie in
                            movie.genres.contains(searchText)
                        })
        results.formUnion( movies.filter { movie in
                            movie.title.contains(searchText)
                        })
        results.formUnion( movies.filter { movie in
                            movie.directors.contains(searchText)
                        })
                
        return Array(results)
    }
    
    /// This method fetch movies from JSON File
    static func fetchMovies() -> [Movie]? {
        let fileName = "movies"
        guard let data = JSONManager.getDataFromJsonFile(with: fileName) else {
            return nil
        }

        //// If we want to fetch Data from URL
//        guard let url = URL(string: "pasteURLHere") else {
//            return nil
//        }
//        guard let data = await NetworkManager.load(with: url) else {
//            return nil
//        }

        if let decodedMovies = JSONManager.decodeData(into: [Movie].self, from: data) {
            return decodedMovies
        }
        return nil
    }
}

struct Movie: Codable, Hashable  {
    
    let title: String
    let year: String
    let rated: String
    let released: String
    let runtime: String
    let genres: String
    let directors: String
    let writer: String
    let actors: String
    let plot: String
    let language: String
    let country: String
    let awards: String
    let poster: String
    let ratings: [Rating]
    let metascore: String
    let imdbRating: String
    let imdbVotes: String
    let imdbID: String
    let type: String
    let dvd: String?
    let boxOffice: String?
    let production: String?
    let website: String?
    let response: String

    enum CodingKeys: String, CodingKey {
        
        case title = "Title"
        case year = "Year"
        case rated = "Rated"
        case released = "Released"
        case runtime = "Runtime"
        case genres = "Genre"
        case directors = "Director"
        case writer = "Writer"
        case actors = "Actors"
        case plot = "Plot"
        case language = "Language"
        case country = "Country"
        case awards = "Awards"
        case poster = "Poster"
        case ratings = "Ratings"
        case metascore = "Metascore"
        case imdbRating, imdbVotes, imdbID
        case type = "Type"
        case dvd = "DVD"
        case boxOffice = "BoxOffice"
        case production = "Production"
        case website = "Website"
        case response = "Response"
    }
        
    static func == (lhs: Movie, rhs: Movie) -> Bool {
        lhs.imdbID == rhs.imdbID
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(imdbID)
    }
}

struct Rating: Codable, Hashable {
    
    let source: String
    let value: String

    enum CodingKeys: String, CodingKey {
        case source = "Source"
        case value = "Value"
    }
}

struct HomeViewOptions: Codable {
    
    var years: Set<String> = []
    var genres: Set<String> = []
    var directors: Set<String> = []
    var actors: Set<String> = []
    var allMovies: Set<String> = []
}

// make it work for allMovies also - done
// RxSwift for home view model - done
// error handling for JSON Failure - done
// add dev documentation -
// Code Reusability - done
// Make it work for a URL also -> done

// Making this as a framework
// Unit Testing
