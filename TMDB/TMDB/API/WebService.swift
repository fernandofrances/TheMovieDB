//
//  WebService.swift
//  TMDB
//
//  Created by Fernando Frances  on 26/3/22.
//

import Foundation
import Combine

final internal class WebService {
    
    private let configuration: WebServiceConfiguration
    private let session = URLSession(configuration: .default)
    private let decoder = JSONDecoder()
    
    init(configuration: WebServiceConfiguration) {
        self.configuration = configuration
    }
    
    func call<Value>(endpoint: Endpoint, httpCodes: HTTPCodes = .success) -> AnyPublisher<Value, Error>
        where Value: Decodable {
        do {
            let request = try endpoint.request(with: configuration.baseURL, adding: configuration.parameters)
            return session
                .dataTaskPublisher(for: request)
                .requestJSON(httpCodes: httpCodes)
        } catch let error {
            return Fail<Value, Error>(error: error).eraseToAnyPublisher()
        }
        
    }
}

// MARK: - Helpers

private extension Publisher where Output == URLSession.DataTaskPublisher.Output {
    func requestJSON<Value>(httpCodes: HTTPCodes) -> AnyPublisher<Value, Error> where Value: Decodable {
        return tryMap {
                assert(!Thread.isMainThread)
                guard let code = ($0.1 as? HTTPURLResponse)?.statusCode else {
                    throw APIError.unexpectedResponse
                }
                guard httpCodes.contains(code) else {
                    throw APIError.httpCode(code)
                }
                return $0.0
            }
            .decode(type: Value.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
