//
//  MockImagesRepository.swift
//  TMDB
//
//  Created by Fernando Frances  on 27/3/22.
//

import Foundation
import Combine

struct MockImagesRepository: ImagesRepositoryProtocol {
    
    static var mockBaseURL: URL {
        URL(string: "any")!
    }
    
    func loadConfiguration() -> AnyPublisher<Configuration, Error> {
        return Just(Configuration(images: Configuration.Images(baseURL: Self.mockBaseURL)))
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
}

struct MockImagesRepositoryError: ImagesRepositoryProtocol {
    
    func loadConfiguration() -> AnyPublisher<Configuration, Error> {
        return Fail(error: APIError.unexpectedResponse)
        .eraseToAnyPublisher()
    }
}
