//
//  ImagesService.swift
//  TMDB
//
//  Created by Fernando Frances  on 27/3/22.
//

import Foundation
import Combine

struct ImagesService {
    
    let repository: ImagesRepositoryProtocol
    
    func loadConfiguration() -> AnyPublisher<Configuration, Never> {
        repository
            .loadConfiguration()
            .replaceError(with: Configuration.default)
            .eraseToAnyPublisher()
    }
}
