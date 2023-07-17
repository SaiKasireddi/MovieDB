//
//  String+Extension.swift
//  MovieDB
//
//  Created by Sai Kumar Kasireddi on 12/07/23.
//

import Foundation

extension String {
    
    var localised: String {
        NSLocalizedString(self, comment: "")
    }
}
