//
//  JSONManager.swift
//  MovieDB
//
//  Created by Sai Kumar Kasireddi on 12/07/23.
//

import Foundation

struct JSONManager {
    
    /// This method fetches data from given JSON file name
    static func getDataFromJsonFile(with fileName: String) -> Data? {
        guard let url = Bundle.main.url(forResource: fileName, withExtension: "json") else {
            return nil
        }
        do {
            return try Data(contentsOf: url)
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
    
    /// This method converts JSON Data ("data") into Swift Model ("model")
    static func decodeData<Model: Decodable>(into model: Model.Type, from data: Data) -> Model? {
        do {
            let dataInModel: Model = try JSONDecoder().decode(model.self, from: data)
            return dataInModel
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
}
