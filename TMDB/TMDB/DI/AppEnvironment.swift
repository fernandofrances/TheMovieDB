//
//  AppEnvironment.swift
//  TMDB
//
//  Created by Fernando Frances  on 26/3/22.
//

import Foundation

struct AppEnvironment {
    let store: AppStore
}

extension AppEnvironment {
    
    static func bootstrap() -> AppEnvironment {
        
        let appState = AppState.initial
        let webService = WebService(configuration: WebServiceConfiguration.default)
        
        let topRatedRepository = TopRatedRepository(webService: webService)
        let showDetailRepository = ShowDetailRepository(webService: webService)
        
        let topRatedService = TopRatedService(repository: topRatedRepository)
        let showDetailService = ShowDetailService(repository: showDetailRepository)
        
        let topRatedMiddleware = topRatedMiddleware(service: topRatedService)
        let showDetailMiddleware = showDetailMiddleware(service: showDetailService)
        
        let store = AppStore(initial: appState, reducer: appReducer, middlewares: [topRatedMiddleware, showDetailMiddleware])
        
        return AppEnvironment(store: store)
    }
}
