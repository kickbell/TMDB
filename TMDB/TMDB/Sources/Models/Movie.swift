//
//  Movie.swift
//  TMDB
//
//  Created by jc.kim on 2/18/23.
//

import Foundation

struct Movie {
    let backdropPath: String?
    let posterPath: String?
    let id: Int
    let overview: String
    let releaseDate: String
    let title: String
    let voteAverage: Double
    let voteCount: Int
}

extension Movie: Hashable {
    public static func == (lhs: Movie, rhs: Movie) -> Bool {
        return lhs.id == rhs.id
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

extension Movie: Decodable {
    enum CodingKeys: String, CodingKey {
        case overview
        case id
        case title
        case backdropPath = "backdrop_path"
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}

extension Movie {
    static let dummy = Movie(backdropPath: nil, posterPath: nil, id: 900901, overview: "'Ironman Arafat', ran 1004 kilometers from Teknaf to Tetulia in 20 days, swam the Bengali Channel 6 times, completed the world's toughest one-day Ironman Triathlon Challenge three times, and became the first Bangladeshi to win the 'Ironman 70.3 World Championship'.", releaseDate: "2021-11-21", title: "Ironman", voteAverage: 0, voteCount: 0)
}
