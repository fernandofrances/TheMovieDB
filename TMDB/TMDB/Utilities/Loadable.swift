//
//  Loadable.swift
//  TMDB
//
//  Created by Fernando Frances  on 26/3/22.
//

import Foundation

enum Loadable<Value>: Equatable {
    case initial
    case progress
    case success(_ value: Value?)
    case failure(_ error: Error)
    
    static func ==(lhs: Loadable, rhs: Loadable) -> Bool {
        switch (lhs, rhs) {
        case (.initial, .initial):
            return true
        case (.progress, .progress):
            return true
        case (.success, .success):
            return true
        case (.failure, .failure):
            return true
        default:
            return false
        }
    }
}

extension Loadable: CaseIterable {
    static var allCases: [Loadable] {
        return  [
            .initial,
            .progress,
            .success(nil),
            .failure(DummyError.dummyError)
        ]
        
    }

    enum DummyError: Error {
        case dummyError
    }
}


