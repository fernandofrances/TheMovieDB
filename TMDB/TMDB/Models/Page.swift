//
//  Page.swift
//  TMDB
//
//  Created by Fernando Frances  on 26/3/22.
//

import Foundation

struct Page<T: Decodable>: Decodable{
    let page: Int
    let totalPages: Int
    let totalResults: Int
    let results: [T]

    private enum CodingKeys: String, CodingKey {
        case page
        case totalPages = "total_pages"
        case totalResults = "total_results"
        case results
    }
}

extension Page: Mockable {
    static var fileName: String {
        "Page"
    }
}

//extension Page {
//    
//    private class Dummy { }
//    
//    static var mock: Page<T> {
//       
//        guard let url = Bundle(for: Dummy.self).url(forResource: "Page",
//                                        withExtension: "json"),
//              let data = try? Data(contentsOf: url),
//              let page = try? JSONDecoder().decode(Page<T>.self, from: data) else {
//                    fatalError()
//                }
//        return page
//    }
//}
