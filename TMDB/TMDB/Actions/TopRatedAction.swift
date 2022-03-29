//
//  TopRatedAction.swift
//  TMDB
//
//  Created by Fernando Frances  on 26/3/22.
//

import Foundation

enum TopRatedAction {
    case selectShow(Show)
    case deselectShow
    case loadTopRated(page: Int)
    case setPage(Loadable<Page<Show>>)
}
