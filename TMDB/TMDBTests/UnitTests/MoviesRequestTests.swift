//
//  MoviesRequestTests.swift
//  TMDBTests
//
//  Created by jc.kim on 3/7/23.
//

import XCTest
@testable import TMDB

class MoviesRequestTests: XCTestCase {
    private let request = MoviesRequest()
    private let query = ("ironman", 1)
    
    func test_인기영화_URLRequest생성하기() throws {
        let urlRequest = try request.makeRequest(from: MoviesEndpoint.popular)
        
        XCTAssertEqual(urlRequest.url?.scheme, "https")
        XCTAssertEqual(urlRequest.url?.host, "api.themoviedb.org")
        XCTAssertEqual(urlRequest.url?.path, "/3/movie/popular")
    }
    
    func test_최고평점_URLRequest생성하기() throws {
        let urlRequest = try request.makeRequest(from: MoviesEndpoint.topRated)
        
        XCTAssertEqual(urlRequest.url?.scheme, "https")
        XCTAssertEqual(urlRequest.url?.host, "api.themoviedb.org")
        XCTAssertEqual(urlRequest.url?.path, "/3/movie/top_rated")
    }
    
    func test_개봉예정_URLRequest생성하기() throws {
        let urlRequest = try request.makeRequest(from: MoviesEndpoint.upcomming)
        
        XCTAssertEqual(urlRequest.url?.scheme, "https")
        XCTAssertEqual(urlRequest.url?.host, "api.themoviedb.org")
        XCTAssertEqual(urlRequest.url?.path, "/3/movie/upcoming")
    }
    
    func test_검색_URLRequest생성하기() throws {
        let urlRequest = try request.makeRequest(from: MoviesEndpoint.search(query: query.0, page: query.1))
        let query = urlRequest.url?.query?.components(separatedBy: "query=").last?.components(separatedBy: "&page=")
        
        XCTAssertEqual(urlRequest.url?.scheme, "https")
        XCTAssertEqual(urlRequest.url?.host, "api.themoviedb.org")
        XCTAssertEqual(urlRequest.url?.path, "/3/search/movie")
        XCTAssertEqual(query, ["ironman", "1"])
    }
    
    func test_트렌드_URLRequest생성하기() throws {
        let urlRequest = try request.makeRequest(from: MoviesEndpoint.trending)
        
        XCTAssertEqual(urlRequest.url?.scheme, "https")
        XCTAssertEqual(urlRequest.url?.host, "api.themoviedb.org")
        XCTAssertEqual(urlRequest.url?.path, "/3/trending/movie/day")
    }
    
    func test_인기영화_데이터파싱하기() throws {
        let movies = Movies.loadFromFile("MoviePopulor.json", MoviesRequestTests.self)
        let target = movies.items.first

        XCTAssertEqual(target?.releaseDate, "2023-02-01")
        XCTAssertEqual(target?.title, "똑똑똑")
        XCTAssertEqual(target?.voteAverage, 6.6)
        XCTAssertEqual(target?.voteCount, 778)
    }
    
    func test_최고평점_데이터파싱하기() throws {
        let movies = Movies.loadFromFile("MovieTopRated.json", MoviesRequestTests.self)
        let target = movies.items.first

        XCTAssertEqual(target?.releaseDate, "1972-03-14")
        XCTAssertEqual(target?.title, "The Godfather")
        XCTAssertEqual(target?.voteAverage, 8.7)
        XCTAssertEqual(target?.voteCount, 17555)
    }
    
    func test_개봉예정_데이터파싱하기() throws {
        let movies = Movies.loadFromFile("MovieUpcoming.json", MoviesRequestTests.self)
        let target = movies.items.first

        XCTAssertEqual(target?.releaseDate, "2023-02-01")
        XCTAssertEqual(target?.title, "Knock at the Cabin")
        XCTAssertEqual(target?.voteAverage, 6.6)
        XCTAssertEqual(target?.voteCount, 778)
    }
    
    func test_검색_데이터파싱하기() throws {
        let movies = Movies.loadFromFile("MovieSearch.json", MoviesRequestTests.self)
        let target = movies.items.first

        XCTAssertEqual(target?.releaseDate, "2021-11-21")
        XCTAssertEqual(target?.title, "Ironman")
        XCTAssertEqual(target?.voteAverage, 0)
        XCTAssertEqual(target?.voteCount, 0)
    }
    
    func test_트렌드_데이터파싱하기() throws {
        let movies = Movies.loadFromFile("MovieTrend.json", MoviesRequestTests.self)
        let target = movies.items.first

        XCTAssertEqual(target?.releaseDate, "2022-12-28")
        XCTAssertEqual(target?.title, "A Man Called Otto")
        XCTAssertEqual(target?.voteAverage, 7.898)
        XCTAssertEqual(target?.voteCount, 494)
    }
}
