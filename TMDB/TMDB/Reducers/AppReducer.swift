//
//  AppReducer.swift
//  TMDB
//
//  Created by Fernando Frances  on 26/3/22.
//

import Foundation

func appReducer(state: inout AppState, action: AppAction) {
    
    switch(action) {
    case .topRated(action: let action):
        topRatedReducer(state: &state.topRated, action: action)
    case .showDetail(action: let action):
        showDetailReducer(state: &state.showDetail, action: action)
    case .images(action: let action):
        imagesReducer(state: &state.images, action: action)
    }
}

