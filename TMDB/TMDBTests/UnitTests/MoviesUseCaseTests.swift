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
    private let imageLoaderService = ImageLoaderServiceMock()
    private var useCase: MoviesService!
    private let movieId = 475557
    
    typealias mep = MoviesEndpoint
    
    override func setUp() {
        useCase = MoviesService(networkService: networkService)
    }
    
    // MARK: - MoviePopulor

    func test_인기영화_로딩을_성공했을때() {
        // Given
        let expectation = self.expectation(description: "moviePopulor")
        let moviePopulor = Movies.loadFromFile("MoviePopulor.json", MoviesRequestTests.self)
        networkService.responses[mep.popular.path] = moviePopulor
        
        
        // When
        Task(priority: .background) {
            guard case let .success(result) = await useCase.popular() else {
                XCTFail()
                return
            }
            XCTAssertEqual(result.items.first?.title, "똑똑똑")
            expectation.fulfill()
        }
         
        // Then
        self.waitForExpectations(timeout: 1.0, handler: nil)
    }
    
    
    func test_인기영화_로딩을_실패했을때() {
        // Given
        let expectation = self.expectation(description: "moviePopulor")
        networkService.responses[mep.popular.path] = NetworkError.noResponse

        // When
        Task(priority: .background) {
            guard case let .failure(error) = await useCase.popular() else {
                XCTFail()
                return
            }
            XCTAssertEqual(error, NetworkError.noResponse)
            expectation.fulfill()
        }
         
        // Then
        self.waitForExpectations(timeout: 1.0, handler: nil)
    }

    // MARK: - MovieTopRated
    
    func test_최고평점_로딩을_성공했을때() {
        // Given
        let expectation = self.expectation(description: "movieTopRated")
        let movieTopRated = Movies.loadFromFile("MovieTopRated.json", MoviesRequestTests.self)
        networkService.responses[mep.topRated.path] = movieTopRated
        
        
        // When
        Task(priority: .background) {
            guard case let .success(result) = await useCase.topRated() else {
                XCTFail()
                return
            }
            XCTAssertEqual(result.items.first?.title, "The Godfather")
            expectation.fulfill()
        }
         
        // Then
        self.waitForExpectations(timeout: 1.0, handler: nil)
    }
    
    
    func test_최고평점_로딩을_실패했을때() {
        // Given
        let expectation = self.expectation(description: "movieTopRated")
        networkService.responses[mep.topRated.path] = NetworkError.noResponse

        // When
        Task(priority: .background) {
            guard case let .failure(error) = await useCase.topRated() else {
                XCTFail()
                return
            }
            XCTAssertEqual(error, NetworkError.noResponse)
            expectation.fulfill()
        }
         
        // Then
        self.waitForExpectations(timeout: 1.0, handler: nil)
    }
    
    // MARK: - MovieUpcoming
    
    func test_개봉예정_로딩을_성공했을때() {
        // Given
        let expectation = self.expectation(description: "movieUpcoming")
        let movieUpcoming = Movies.loadFromFile("MovieUpcoming.json", MoviesRequestTests.self)
        networkService.responses[mep.upcomming.path] = movieUpcoming
        
        
        // When
        Task(priority: .background) {
            guard case let .success(result) = await useCase.upcoming() else {
                XCTFail()
                return
            }
            XCTAssertEqual(result.items.first?.title, "Knock at the Cabin")
            expectation.fulfill()
        }
         
        // Then
        self.waitForExpectations(timeout: 1.0, handler: nil)
    }
    
    
    func test_개봉예정_로딩을_실패했을때() {
        // Given
        let expectation = self.expectation(description: "movieUpcoming")
        networkService.responses[mep.topRated.path] = NetworkError.noResponse

        // When
        Task(priority: .background) {
            guard case let .failure(error) = await useCase.topRated() else {
                XCTFail()
                return
            }
            XCTAssertEqual(error, NetworkError.noResponse)
            expectation.fulfill()
        }
         
        // Then
        self.waitForExpectations(timeout: 1.0, handler: nil)
    }
    
    // MARK: - MovieSearch
    
    func test_영화검색_로딩을_성공했을때() {
        // Given
        let query = ("ironman",1)
        let expectation = self.expectation(description: "movieSearch")
        let movieSearch = Movies.loadFromFile("MovieSearch.json", MoviesRequestTests.self)
        networkService.responses[mep.search(query: query.0, page: query.1).path] = movieSearch
        
        
        // When
        Task(priority: .background) {
            guard case let .success(result) = await useCase.search(query: query.0, page: query.1) else {
                XCTFail()
                return
            }
            XCTAssertEqual(result.items.first?.title, "Ironman")
            expectation.fulfill()
        }
         
        // Then
        self.waitForExpectations(timeout: 1.0, handler: nil)
    }
    
    func test_영화검색_로딩을_실패했을때() {
        // Given
        let query = ("ironman",1)
        let expectation = self.expectation(description: "movieSearch")
        networkService.responses[mep.search(query: query.0, page: query.1).path] = NetworkError.noResponse

        // When
        Task(priority: .background) {
            guard case let .failure(error) = await useCase.search(query: query.0, page: query.1) else {
                XCTFail()
                return
            }
            XCTAssertEqual(error, NetworkError.noResponse)
            expectation.fulfill()
        }
         
        // Then
        self.waitForExpectations(timeout: 1.0, handler: nil)
    }
    
    // MARK: - MovieTrend
    
    func test_트렌드_로딩을_성공했을때() {
        // Given
        let expectation = self.expectation(description: "movieTrend")
        let movieTrend = Movies.loadFromFile("MovieTrend.json", MoviesRequestTests.self)
        networkService.responses[mep.trending.path] = movieTrend
        
        
        // When
        Task(priority: .background) {
            guard case let .success(result) = await useCase.trending() else {
                XCTFail()
                return
            }
            XCTAssertEqual(result.items.first?.title, "A Man Called Otto")
            expectation.fulfill()
        }
         
        // Then
        self.waitForExpectations(timeout: 1.0, handler: nil)
    }
    
    
    func test_트렌드_로딩을_실패했을때() {
        // Given
        let expectation = self.expectation(description: "movieTrend")
        networkService.responses[mep.trending.path] = NetworkError.noResponse

        // When
        Task(priority: .background) {
            guard case let .failure(error) = await useCase.trending() else {
                XCTFail()
                return
            }
            XCTAssertEqual(error, NetworkError.noResponse)
            expectation.fulfill()
        }
         
        // Then
        self.waitForExpectations(timeout: 1.0, handler: nil)
    }
    
    // MARK: - Genres
    
    func test_장르_로딩을_성공했을때() {
        // Given
        let expectation = self.expectation(description: "genres")
        let genres = Genres.loadFromFile("Genres.json", GenresRequestTests.self)
        networkService.responses[mep.genre.path] = genres
        
        
        // When
        Task(priority: .background) {
            guard case let .success(result) = await useCase.genre() else {
                XCTFail()
                return
            }
            XCTAssertEqual(result.items.count, 19)
            expectation.fulfill()
        }
         
        // Then
        self.waitForExpectations(timeout: 1.0, handler: nil)
    }
    
    
    func test_장르_로딩을_실패했을때() {
        // Given
        let expectation = self.expectation(description: "genres")
        networkService.responses[mep.genre.path] = NetworkError.noResponse

        // When
        Task(priority: .background) {
            guard case let .failure(error) = await useCase.genre() else {
                XCTFail()
                return
            }
            XCTAssertEqual(error, NetworkError.noResponse)
            expectation.fulfill()
        }
         
        // Then
        self.waitForExpectations(timeout: 1.0, handler: nil)
    }

    // MARK: - MovieDetails

    func test_영화디테일_로딩을_성공했을때() {
        // Given
        let expectation = self.expectation(description: "movieDetail")
        let movieDetail = MovieDetail.loadFromFile("MovieDetails.json", MovieDetailRequestTests.self)
        networkService.responses[mep.movieDetail(id: movieId).path] = movieDetail

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
    
    
    func test_영화디테일_로딩을_실패했을때() {
        // Given
        let expectation = self.expectation(description: "movieDetail")
        networkService.responses[mep.movieDetail(id: movieId).path] = NetworkError.noResponse

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
    
    // MARK: - LoadImage
    
    func test_이미지_로딩을_성공했을때() {
        // Given
        let expectation = self.expectation(description: "loadImage")
        let moviePopulor = Movies.loadFromFile("MoviePopulor.json", MoviesRequestTests.self)
        let path = moviePopulor.items.first?.backdropPath ?? ""
        let url = URL(string: ApiConstants.mediumImageUrl + path)!

        // When
        imageLoaderService.loadImage(from: url) { (result: Result<UIImage?, Never>) in
            guard case let .success(image) = result else {
                XCTFail()
                return
            }
            XCTAssertEqual(image, UIImage())
            expectation.fulfill()
        }

        // Then
        self.waitForExpectations(timeout: 1.0, handler: nil)
    }
    

}
