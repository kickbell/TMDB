//
//  GenresRequestTests.swift
//  TMDBTests
//
//  Created by jc.kim on 3/7/23.
//

import XCTest
@testable import TMDB

class GenresRequestTests: XCTestCase {
    private let request = GenresRequest()
    
    func test_URLRequest생성하기() throws {
        let urlRequest = try request.makeRequest(from: MoviesEndpoint.genre)
        
        XCTAssertEqual(urlRequest.url?.path, "/3/genre/movie/list")
    }
    
    func test_데이터파싱하기() throws {
        let genresData = Genres.loadDataFromFile("Genres.json", GenresRequestTests.self)
        let genres = try request.parseResponse(data: genresData)
        
        XCTAssertEqual(genres.items.count, 19)        
    }
}
