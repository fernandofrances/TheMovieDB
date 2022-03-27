//
//  Endpoint.swift
//  TMDB
//
//  Created by Fernando Frances  on 26/3/22.
//

import Foundation

internal enum Endpoint {
    case configuration
    case topRated(page: Int)
    case similarShows(identifier: Int64, page: Int)
    case show(identifier: Int64)
}

internal extension Endpoint {
    func request(with baseURL: String, adding parameters: [String: String]) throws -> URLRequest {
        
        guard let url = URL(string: baseURL + path) else {
            throw APIError.invalidURL
        }
        
        var newParameters = self.parameters
        parameters.forEach { newParameters.updateValue($1, forKey: $0) }
        
        var components = URLComponents(url: url, resolvingAgainstBaseURL: false)!
        components.queryItems = newParameters.map(URLQueryItem.init)

        var request = URLRequest(url: components.url!)
        request.httpMethod = method.rawValue

        return request
    }
}

extension Endpoint: CaseIterable {
    static var allCases: [Endpoint] {
        return  [.configuration,
                 .topRated(page: 1),
                 .similarShows(identifier: 1, page: 1),
                 .show(identifier: 1)]
    }
}

enum HTTPMethod: String {
    case get = "GET"
}

extension Endpoint {
    var method: HTTPMethod {
        return .get
    }

    var path: String {
        switch self {
        case .configuration:
            return "/configuration"
        case .topRated:
            return "/tv/top_rated"
        case .similarShows(let identifier, _):
            return "/tv/\(identifier)/similar"
        case .show(let identifier):
            return "/tv/\(identifier)"
        }
    }
    var parameters: [String: String] {
        switch self {
        case .configuration:
            return [:]
        case .topRated(page: let page):
            return [
                "page": String(page)
            ]
        case .similarShows(_, let page):
            return ["page": String(page)]
        case .show:
            return [:]
        }
    }
}

enum APIError: Swift.Error {
    case invalidURL
    case httpCode(HTTPCode)
    case unexpectedResponse
    case imageProcessing([URLRequest])
}

extension APIError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .invalidURL: return "Invalid URL"
        case let .httpCode(code): return "Unexpected HTTP code: \(code)"
        case .unexpectedResponse: return "Unexpected response from the server"
        case .imageProcessing: return "Unable to load image"
        }
    }
}


typealias HTTPCode = Int
typealias HTTPCodes = Range<HTTPCode>

extension HTTPCodes {
    static let success = 200 ..< 300
}
