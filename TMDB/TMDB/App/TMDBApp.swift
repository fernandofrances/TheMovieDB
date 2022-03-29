//
//  TMDBApp.swift
//  TMDB
//
//  Created by Fernando Frances  on 26/3/22.
//

import SwiftUI

@main
struct TMDBApp: App {
    
    let environment = AppEnvironment.bootstrap()
    
    var body: some Scene {
        WindowGroup {
            TopRatedView()
                .environmentObject(environment.store)
                .onAppear {
                    environment.store.dispatch(.topRated(action: .loadTopRated(page: 1)))
                }
        }
    }
}
