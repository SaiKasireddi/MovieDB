//
//  HomeAction.swift
//  MovieDB
//
//  Created by Sai Kumar Kasireddi on 17/07/23.

import Foundation

enum HomeAction: EventRepresentable {
    
    case onAppear
    case clickedOnSearchButton(searchText: String)
}
