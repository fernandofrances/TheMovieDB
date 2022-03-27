//
//  TopRatedReducer.swift
//  TMDB
//
//  Created by Fernando Frances  on 27/3/22.
//

import Foundation

func topRatedReducer(state: inout TopRatedState, action: TopRatedAction) {
    switch(action) {
    case .loadTopRated:
        state.topRated = Loadable<Page<Show>>.progress
    case .setPage(let loadablePage):
        state.topRated = loadablePage
    }
}
