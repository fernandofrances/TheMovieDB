//
//  DetailReducer.swift
//  TMDB
//
//  Created by Fernando Frances  on 27/3/22.
//

import Foundation

func showDetailReducer(state: inout ShowDetailState, action: ShowDetailAction) {
    switch(action) {
    case .loadDetail:
        state.currentDetail = Loadable<ShowDetail>.progress
    case .loadSimilars:
        state.currentSimilars = Loadable<Page<Show>>.progress
    case .setDetail(let loadableDetail):
        state.currentDetail = loadableDetail
    case .setSimilars(let loadableSimilars):
        state.currentSimilars = loadableSimilars
    case .removeCurrentDetail:
        state.currentDetail = .initial
        state.currentSimilars = .initial
    }
    
}
