//
//  ShowDetail.swift
//  TMDB
//
//  Created by Fernando Frances  on 26/3/22.
//

import Foundation

struct ShowDetail: Decodable {
    let backdropPath: String?
    let identifier: Int64
    let overview: String
    let posterPath: String?
    let releaseDate: String
    let episodes: Int64
    let name: String
    let vote: Double?
    let genres: [Genre]
    
    private enum CodingKeys: String, CodingKey {
        case backdropPath = "backdrop_path"
        case identifier = "id"
        case overview
        case posterPath = "poster_path"
        case releaseDate = "first_air_date"
        case episodes = "number_of_episodes"
        case name
        case genres
        case vote = "vote_average"
    }
}

extension ShowDetail: Mockable {
    static var fileName: String {
        "ShowDetail"
    }
}

extension ShowDetail: Hashable, Equatable {
    static func == (lhs: ShowDetail, rhs: ShowDetail) -> Bool {
        lhs.identifier == rhs.identifier
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.identifier)
    }
}
