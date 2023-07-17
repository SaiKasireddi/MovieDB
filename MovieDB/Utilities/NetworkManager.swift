//
//  NetworkManager.swift
//  MovieDB
//
//  Created by Sai Kumar Kasireddi on 17/07/23.
//

import Foundation

final class NetworkManager {

    //MARK: Methods

    /// This method makes a network call and fetches data with given url
    static func load(with url: URL) async -> Data? {
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            
            guard (response as? HTTPURLResponse)?.statusCode == 200 else {
                return nil
            }
            
            return data
        } catch {
            print("Network Call Failed, \(error.localizedDescription)")
            return nil
        }
    }
}
