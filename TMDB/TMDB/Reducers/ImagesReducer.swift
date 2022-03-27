//
//  ImagesReducer.swift
//  TMDB
//
//  Created by Fernando Frances  on 27/3/22.
//

import Foundation

func imagesReducer(state: inout ImagesState, action: ImagesAction) {
    switch(action) {
    case .setConfiguration(let configuration):
        state.configuration = configuration
    default:
        break
    }
}
