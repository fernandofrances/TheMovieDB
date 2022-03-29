//
//  DetailAction.swift
//  TMDB
//
//  Created by Fernando Frances  on 26/3/22.
//

import Foundation

enum ShowDetailAction {
    case loadShowDetailAndRelated(identifier: Int64, page: Int)
    case setDetail(Loadable<[ShowDetail]>)
    case removeCurrentDetail
}
