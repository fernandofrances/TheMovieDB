//
//  TopRatedRepository.swift
//  TMDB
//
//  Created by Fernando Frances  on 27/3/22.
//

import Foundation
import Combine

protocol TopRatedRepositoryProtocol {
    func loadTopRated(page: Int) -> AnyPublisher<Page<Show>, Error>
}

struct TopRatedRepository: TopRatedRepositoryProtocol {
    
    let webService: WebService
    
    func loadTopRated(page: Int) -> AnyPublisher<Page<Show>, Error> {
        webService.call(endpoint: .topRated(page: page))
    }
    
}
