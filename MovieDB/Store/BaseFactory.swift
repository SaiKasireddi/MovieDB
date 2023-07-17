//
//  BaseFactory.swift
//  MovieDB
//
//  Created by Sai Kumar Kasireddi on 17/07/23.
//

import Foundation

protocol StateRepresentable {}

protocol EventRepresentable {}

protocol Store {
    associatedtype Action: EventRepresentable
    associatedtype State: StateRepresentable

    @MainActor func reduce(from action: Action) async -> Action?
    func send(_ action: Action)

    var state: State { get }
}

extension Store {
    func send(_ action: Action) {
        Task {
            guard let action = await reduce(from: action) else {
                return
            }
            send(action)
        }
    }
}
