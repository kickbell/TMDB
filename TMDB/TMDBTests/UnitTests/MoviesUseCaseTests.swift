//
//  MoviesUseCaseTests.swift
//  TMDBTests
//
//  Created by jc.kim on 3/8/23.
//

import XCTest
@testable import TMDB

class MoviesUseCaseTests: XCTestCase {
    
    private let networkService = NetworkServiceMock()
    private var useCase: MoviesService!
    private let movieId = 475557
    
    override func setUp() {
        useCase = MoviesService(networkService: networkService)
    }

    func test_영화디테일로딩을_성공했을때() {
        // Given
        let expectation = self.expectation(description: "movieDetail")
        let movieDetail = MovieDetail.loadFromFile("MovieDetails.json", MovieDetailRequestTests.self)
        networkService.responses["/3/movie/\(movieId)"] = movieDetail

        // When
        Task(priority: .background) {
            guard case let .success(result) = await useCase.detail(id: movieId) else {
                XCTFail()
                return
            }
            XCTAssertEqual(result.title, "Joker")
            expectation.fulfill()
        }
         
        // Then
        self.waitForExpectations(timeout: 1.0, handler: nil)
    }
    
    
    func test_영화디테일로딩을_실패했을때() {
        // Given
        let expectation = self.expectation(description: "movieDetail")
        networkService.responses["/3/movie/\(movieId)"] = NetworkError.noResponse

        // When
        Task(priority: .background) {
            guard case let .failure(error) = await useCase.detail(id: movieId) else {
                XCTFail()
                return
            }
            XCTAssertEqual(error, NetworkError.noResponse)
            expectation.fulfill()
        }
         
        // Then
        self.waitForExpectations(timeout: 1.0, handler: nil)
    }
}
