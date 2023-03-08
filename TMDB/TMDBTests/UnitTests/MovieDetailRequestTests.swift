//
//  MoviesRequestTests.swift
//  TMDBTests
//
//  Created by jc.kim on 3/7/23.
//

import XCTest
@testable import TMDB

class MovieDetailRequestTests: XCTestCase {
    private let request = MovieDetailRequest()
    private let movieId = 475557
    
    func test_URLRequest생성하기() throws {
        let urlRequest = try request.makeRequest(from: MoviesEndpoint.movieDetail(id: movieId))
        
        XCTAssertEqual(urlRequest.url?.path, "/3/movie/\(movieId)")
    }
    
    func test_데이터파싱하기() throws {
        let movieDetailData = MovieDetail.loadDataFromFile("MovieDetails.json", MovieDetailRequestTests.self)
        let movieDetail = try request.parseResponse(data: movieDetailData)
        
        XCTAssertEqual(movieDetail.title, "Joker")
    }
}


