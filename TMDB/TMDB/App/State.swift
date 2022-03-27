//
//  State.swift
//  TMDB
//
//  Created by Fernando Frances  on 26/3/22.
//

import Foundation

struct AppState {
    var topRated: TopRatedState
    var showDetail: ShowDetailState
    var images: ImagesState
}

extension AppState {
    static var initial: AppState {
        return AppState(topRated: TopRatedState(),
                        showDetail: ShowDetailState(),
                        images: ImagesState())
    }
}

struct TopRatedState {
    var topRated: Loadable<Page<Show>> = .initial
}

struct ShowDetailState {
    var currentDetail: Loadable<ShowDetail> = .initial
    var currentSimilars: Loadable<Page<Show>> = .initial
}

struct ImagesState {
    var configuration: Configuration = .default
}

