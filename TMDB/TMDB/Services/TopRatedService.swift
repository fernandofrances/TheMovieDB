//
//  TopRatedService.swift
//  TMDB
//
//  Created by Fernando Frances  on 27/3/22.
//

import Foundation
import Combine

struct TopRatedService {
    
    let repository: TopRatedRepositoryProtocol
    
    func loadTopRated(page: Int) -> AnyPublisher<Loadable<Page<Show>>, Error> {
        repository.loadTopRated(page: page)
            .map { .success($0) }
            .eraseToAnyPublisher()
    }
}
