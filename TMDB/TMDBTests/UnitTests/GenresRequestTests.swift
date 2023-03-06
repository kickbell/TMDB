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
        
        XCTAssertEqual(urlRequest.url?.scheme, "https")
        XCTAssertEqual(urlRequest.url?.host, "api.themoviedb.org")
        XCTAssertEqual(urlRequest.url?.path, "/3/genre/movie/list")
    }
    
    func test_데이터파싱하기() throws {
        let target = Genres.loadFromFile("Genres.json", GenresRequestTests.self)
        
        XCTAssertEqual(target.items.count, 19)
        XCTAssertEqual(target.items.first?.id, 28)
        XCTAssertEqual(target.items.first?.name, "Action")
        XCTAssertEqual(target.items.last?.id, 37)
        XCTAssertEqual(target.items.last?.name, "Western")
    }
}
