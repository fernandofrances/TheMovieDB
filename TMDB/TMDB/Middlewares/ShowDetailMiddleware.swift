//
//  ShowDetailMiddleware.swift
//  TMDB
//
//  Created by Fernando Frances  on 27/3/22.
//

import Foundation
import Combine

func showDetailMiddleware(service: ShowDetailService) -> Middleware<AppState, AppAction> {
    
    return { state, action in
        
        switch action {
        case .showDetail(action: .loadDetail(identifier: let identifier)):
            return service.loadShow(identifier: identifier)
                .catch({ error in
                    Just(Loadable.failure(error))
                })
                .map { AppAction.showDetail(action: .setDetail($0)) }
                .eraseToAnyPublisher()
        case .showDetail(action: .loadSimilars(let identifier, let page)):
            return service.loadSimilars(identifier: identifier, page: page)
                .catch({ error in
                    Just(Loadable.failure(error))
                })
                .map { AppAction.showDetail(action: .setSimilars($0)) }
                .eraseToAnyPublisher()
        default:
            break
        }
        
        return Empty().eraseToAnyPublisher()
    }
}
