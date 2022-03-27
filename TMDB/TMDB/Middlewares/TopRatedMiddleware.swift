//
//  TopRatedMiddleware.swift
//  TMDB
//
//  Created by Fernando Frances  on 27/3/22.
//

import Foundation
import Combine

func topRatedMiddleware(service: TopRatedService) -> Middleware<AppState, AppAction> {
    
    return { state, action in
        
        switch action {
        case .topRated(action: .loadTopRated(page: let page)):
            return service.loadTopRated(page: page)
                .catch({ error in
                    Just(Loadable.failure(error))
                })
                .map { AppAction.topRated(action: .setPage($0)) }
                .eraseToAnyPublisher()
        default:
            break
        }
        
        return Empty().eraseToAnyPublisher()
    }
}
