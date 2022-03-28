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
    
    func image(with path: String, size: ImageSize) -> URL {
        return images.baseURL
            .appendingPathComponent(size.rawValue)
            .appendingPathComponent(path)
    }
}

public extension Configuration {
    static let `default` = Configuration(images: Images(baseURL: URL(string: "https://image.tmdb.org/t/p/")!))
}
