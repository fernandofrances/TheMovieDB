//
//  MockTopRatedRepository.swift
//  TMDBTests
//
//  Created by Fernando Frances  on 27/3/22.
//

import Foundation
import Combine

struct MockTopRatedRepository: TopRatedRepositoryProtocol {
    
    private static func topRatedFromJSON() -> Page<Show>? {
        do {
            if let data = "Page".readLocalJSONFile() {
                let decoded = try JSONDecoder().decode(Page<Show>.self, from: data)
                return decoded
            } else {
                throw APIError.unexpectedResponse
            }
        } catch {
            return nil
        }
    }
    
    func loadTopRated(page: Int) -> AnyPublisher<Page<Show>, Error> {
        if let topRated = Self.topRatedFromJSON() {
            return Just(topRated)
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        } else {
            return Fail(error: APIError.unexpectedResponse)
                .eraseToAnyPublisher()
        }
    }
    
    
}

struct MockTopRatedRepositoryError: TopRatedRepositoryProtocol {
    func loadTopRated(page: Int) -> AnyPublisher<Page<Show>, Error> {
        return Fail(error: APIError.unexpectedResponse)
        .eraseToAnyPublisher()

    }
    
    
}
