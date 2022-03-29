//
//  DetailReducer.swift
//  TMDB
//
//  Created by Fernando Frances  on 27/3/22.
//

import Foundation

func showDetailReducer(state: inout ShowDetailState, action: ShowDetailAction) {
    switch(action) {
    case .loadShowDetailAndRelated:
        state.currentDetail = Loadable<[ShowDetail]>.progress
    case .setDetail(let loadableDetail):
        state.currentDetail = loadableDetail
    case .removeCurrentDetail:
        state.currentDetail = .initial
    }
    
}
