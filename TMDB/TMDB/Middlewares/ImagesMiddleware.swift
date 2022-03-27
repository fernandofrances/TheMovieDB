//
//  ImagesMiddleware.swift
//  TMDB
//
//  Created by Fernando Frances  on 27/3/22.
//

import Foundation
import Combine

func imagesMiddleware(service: ImagesService) -> Middleware<AppState, AppAction> {
    
    return { state, action in
        switch action {
        case .images(action: .loadConfiguration):
            return service.loadConfiguration()
                .map { AppAction.images(action: .setConfiguration($0)) }
                .eraseToAnyPublisher()
        default:
            break
        }
        
        return Empty().eraseToAnyPublisher()
    }
}
