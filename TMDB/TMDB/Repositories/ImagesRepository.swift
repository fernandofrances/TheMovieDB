//
//  ImagesRepository.swift
//  TMDB
//
//  Created by Fernando Frances  on 27/3/22.
//

import Foundation
import Combine

protocol ImagesRepositoryProtocol {
    func loadConfiguration() -> AnyPublisher<Configuration, Error>
}

struct ImagesRepository: ImagesRepositoryProtocol {
    
    let webService: WebService
    
    func loadConfiguration() -> AnyPublisher<Configuration, Error> {
        webService.call(endpoint: .configuration)
    }
    
}
