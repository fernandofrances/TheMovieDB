//
//  AppAction.swift
//  TMDB
//
//  Created by Fernando Frances  on 26/3/22.
//

import Foundation

enum AppAction {
    case topRated(action: TopRatedAction)
    case showDetail(action: ShowDetailAction)
    case images(action: ImagesAction)
}
