//
//  DetailAction.swift
//  TMDB
//
//  Created by Fernando Frances  on 26/3/22.
//

import Foundation

enum ShowDetailAction {
    case loadDetail(identifier: Int64)
    case setDetail(Loadable<ShowDetail>)
    case loadSimilars(identifier: Int64, page: Int)
    case setSimilars(Loadable<Page<Show>>)
    case removeCurrentDetail
}
