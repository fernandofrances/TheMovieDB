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
        case .showDetail(action: .loadShowDetailAndRelated(let identifier, let page)):
            return service.loadSimilars(identifier: identifier, page: page)
                .map { page -> [Int64] in
                    var addingOriginal = [identifier]
                    addingOriginal.append(contentsOf: page.results.map { $0.identifier })
                    return addingOriginal
                }
                .flatMap { identifiers in
                    Publishers.Sequence(sequence: identifiers)
                        .flatMap { identifier in
                            service.loadShow(identifier: identifier)
                        }
                        .collect()
                }
                .map { loadableDetails in
                    AppAction.showDetail(action: .setDetail(Loadable.success(loadableDetails)))
                }
                .catch({ error in
                    Just(AppAction.showDetail(action: .setDetail(Loadable.failure(error))))
                })
                .eraseToAnyPublisher()
        default:
            break
        }
        
        return Empty().eraseToAnyPublisher()
    }
}
