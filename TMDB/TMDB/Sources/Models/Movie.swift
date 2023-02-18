//
//  Movie.swift
//  TMDB
//
//  Created by jc.kim on 2/18/23.
//

import Foundation

struct Movie {
    let backdropPath: String?
    let id: Int
    let overview: String
    let releaseDate: String
    let title: String
    let voteAverage: Double
    let voteCount: Int
}

extension Movie: Decodable {
    enum CodingKeys: String, CodingKey {
        case overview
        case id
        case title
        case backdropPath = "backdrop_path"
        case releaseDate = "release_date"
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}
