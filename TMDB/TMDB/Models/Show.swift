//
//  Show.swift
//  TMDB
//
//  Created by Fernando Frances  on 26/3/22.
//

import Foundation

struct Show: Decodable {
    let identifier: Int64
    let title: String
    let posterPath: String?
    let backdropPath: String?
    let firstAirDate: String?
    let genreIdentifiers: [Int]?

    private enum CodingKeys: String, CodingKey {
        case identifier = "id"
        case title = "name"
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
        case firstAirDate = "first_air_date"
        case genreIdentifiers = "genre_ids"
    }
}
