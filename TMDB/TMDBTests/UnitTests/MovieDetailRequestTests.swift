//
//  MoviesRequestTests.swift
//  TMDBTests
//
//  Created by jc.kim on 3/7/23.
//

import XCTest
@testable import TMDB

class MovieDetailRequestTests: XCTestCase {
    private let movieId = 475557
    private let request = MovieDetailRequest()
    
    func test_URLRequest생성하기() throws {
        let urlRequest = try request.makeRequest(from: MoviesEndpoint.movieDetail(id: movieId))
        
        XCTAssertEqual(urlRequest.url?.scheme, "https")
        XCTAssertEqual(urlRequest.url?.host, "api.themoviedb.org")
        XCTAssertEqual(urlRequest.url?.path, "/3/movie/\(movieId)")
    }
    
    func test_데이터파싱하기() throws {
        let target = MovieDetail.loadFromFile("MovieDetails.json", MovieDetailRequestTests.self)
        
        XCTAssertEqual(target.releaseDate, "2019-10-01")
        XCTAssertEqual(target.title, "Joker")
        XCTAssertEqual(target.voteAverage, 8.169)
        XCTAssertEqual(target.runtime, 122)
        XCTAssertEqual(target.tagline, "Put on a happy face.")
    }
}


