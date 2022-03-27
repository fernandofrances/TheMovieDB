//
//  DetailRepository.swift
//  TMDB
//
//  Created by Fernando Frances  on 27/3/22.
//

import Foundation
import Combine

protocol ShowDetailRepositoryProtocol {
    func loadShowDetail(identifier: Int64) -> AnyPublisher<ShowDetail, Error>
    func loadShowSimilars(identifier: Int64, page: Int) -> AnyPublisher<Page<Show>, Error>
}


struct ShowDetailRepository: ShowDetailRepositoryProtocol {
    
    let webService: WebService
    
    func loadShowDetail(identifier: Int64) -> AnyPublisher<ShowDetail, Error> {
        webService.call(endpoint: .show(identifier: identifier))
    }
    
    func loadShowSimilars(identifier: Int64, page: Int) -> AnyPublisher<Page<Show>, Error> {
        webService.call(endpoint: .similarShows(identifier: identifier, page: page))
    }
    
    
}
