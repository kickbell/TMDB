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
        
        XCTAssertEqual(urlRequest.url?.path, "/3/movie/popular")
    }
    
    func test_최고평점_URLRequest생성하기() throws {
        let urlRequest = try request.makeRequest(from: MoviesEndpoint.topRated)
        
        XCTAssertEqual(urlRequest.url?.path, "/3/movie/top_rated")
    }
    
    func test_개봉예정_URLRequest생성하기() throws {
        let urlRequest = try request.makeRequest(from: MoviesEndpoint.upcomming)
        
        XCTAssertEqual(urlRequest.url?.path, "/3/movie/upcoming")
    }
    
    func test_검색_URLRequest생성하기() throws {
        let urlRequest = try request.makeRequest(from: MoviesEndpoint.search(query: query.0, page: query.1))
        let query = urlRequest.url?.query?.components(separatedBy: "query=").last?.components(separatedBy: "&page=")
        
        XCTAssertEqual(query, ["ironman", "1"])
    }
    
    func test_트렌드_URLRequest생성하기() throws {
        let urlRequest = try request.makeRequest(from: MoviesEndpoint.trending)
        
        XCTAssertEqual(urlRequest.url?.path, "/3/trending/movie/day")
    }
    
    func test_인기영화_데이터파싱하기() throws {
        let moviesData = Movies.loadDataFromFile("MoviePopulor.json", MoviesRequestTests.self)
        let movies = try request.parseResponse(data: moviesData)
        
        XCTAssertEqual(movies.items.first?.title, "똑똑똑")
    }
    
    func test_최고평점_데이터파싱하기() throws {
        let moviesData = Movies.loadDataFromFile("MovieTopRated.json", MoviesRequestTests.self)
        let movies = try request.parseResponse(data: moviesData)

        XCTAssertEqual(movies.items.first?.title, "The Godfather")
    }
    
    func test_개봉예정_데이터파싱하기() throws {
        let moviesData = Movies.loadDataFromFile("MovieUpcoming.json", MoviesRequestTests.self)
        let movies = try request.parseResponse(data: moviesData)

        XCTAssertEqual(movies.items.first?.title, "Knock at the Cabin")
    }
    
    func test_검색_데이터파싱하기() throws {
        let moviesData = Movies.loadDataFromFile("MovieSearch.json", MoviesRequestTests.self)
        let movies = try request.parseResponse(data: moviesData)

        XCTAssertEqual(movies.items.first?.title, "Ironman")
    }
    
    func test_트렌드_데이터파싱하기() throws {
        let moviesData = Movies.loadDataFromFile("MovieTrend.json", MoviesRequestTests.self)
        let movies = try request.parseResponse(data: moviesData)

        XCTAssertEqual(movies.items.first?.title, "A Man Called Otto")
    }
}
