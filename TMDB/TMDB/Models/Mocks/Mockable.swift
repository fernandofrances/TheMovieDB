//
//  Mockable.swift
//  TMDB
//
//  Created by Fernando Frances  on 28/3/22.
//

import Foundation

protocol Mockable {
    static var fileName: String { get }
    static var mock: Self { get }
}

private class Dummy { }

extension Mockable where Self: Decodable {
    
    static var mock: Self {
        guard let url = Bundle(for: Dummy.self).url(forResource: Self.fileName,
                                                    withExtension: "json"),
              let data = try? Data(contentsOf: url),
              let result = try? JSONDecoder().decode(Self.self, from: data) else {
                  fatalError("Error Decoding Mock JSON file")
              }
        return result
    }
}
