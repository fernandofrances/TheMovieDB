//
//  DetailService.swift
//  TMDB
//
//  Created by Fernando Frances  on 27/3/22.
//

import Foundation
import Combine

struct ShowDetailService {
    
    let repository: ShowDetailRepositoryProtocol
    
    func loadShow(identifier: Int64) -> AnyPublisher<ShowDetail, Error> {
        repository.loadShowDetail(identifier: identifier)
            .eraseToAnyPublisher()
    }
    
    func loadSimilars(identifier: Int64, page: Int) -> AnyPublisher<Page<Show>, Error> {
        repository.loadShowSimilars(identifier: identifier, page: page)
            .eraseToAnyPublisher()
    }

}
