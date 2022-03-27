//
//  MockShowDetailRepository.swift
//  TMDBTests
//
//  Created by Fernando Frances  on 27/3/22.
//

import Foundation
import Combine

struct MockShowDetailRepository: ShowDetailRepositoryProtocol {
    
    static func showDetailFromJson() -> ShowDetail? {
        do {
            if let data = "ShowDetail".readLocalJSONFile() {
                let decoded = try JSONDecoder().decode(ShowDetail.self, from: data)
                return decoded
            } else {
                throw APIError.unexpectedResponse
            }
        } catch {
            return nil
        }
    }
    
    private static func similarsFromJson() -> Page<Show>? {
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
    


    func loadShowDetail(identifier: Int64) -> AnyPublisher<ShowDetail, Error> {
        if let showDetail = Self.showDetailFromJson() {
            return Just(showDetail)
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        } else {
            return Fail(error: APIError.unexpectedResponse)
                .eraseToAnyPublisher()
        }
    }
    
    func loadShowSimilars(identifier: Int64, page: Int) -> AnyPublisher<Page<Show>, Error> {
        if let similars = Self.similarsFromJson() {
            return Just(similars)
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        } else {
            return Fail(error: APIError.unexpectedResponse)
                .eraseToAnyPublisher()
        }
    }
    
    
}

struct MockShowDetailRepositoryError: ShowDetailRepositoryProtocol {
    func loadShowDetail(identifier: Int64) -> AnyPublisher<ShowDetail, Error> {
        return Fail(error: APIError.unexpectedResponse)
        .eraseToAnyPublisher()
    }
    
    func loadShowSimilars(identifier: Int64, page: Int) -> AnyPublisher<Page<Show>, Error> {
        return Fail(error: APIError.unexpectedResponse)
        .eraseToAnyPublisher()
    }
    
    
}
