//
//  TopRatedReducer.swift
//  TMDB
//
//  Created by Fernando Frances  on 27/3/22.
//

import Foundation

func topRatedReducer(state: inout TopRatedState, action: TopRatedAction) {
    switch(action) {
    case .selectShow(let show):
        state.showSelected = true
        state.selectedShow = show
    case .deselectShow:
        state.showSelected = false
        state.selectedShow = nil
    case .loadTopRated:
        state.topRated = Loadable<Page<Show>>.progress
    case .setPage(let loadablePage):
        state.topRated = loadablePage
    }
}
