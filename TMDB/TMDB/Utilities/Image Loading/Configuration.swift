//
//  Configuration.swift
//  TMDB
//
//  Created by Fernando Frances  on 27/3/22.
//

import Foundation

public struct Configuration: Decodable {
    public struct Images: Decodable {
        public let baseURL: URL

        private enum CodingKeys: String, CodingKey {
            case baseURL = "secure_base_url"
        }
    }

    public let images: Images
}

public extension Configuration {
    static let `default` = Configuration(images: Images(baseURL: URL(string: "https://image.tmdb.org/t/p/")!))
}
