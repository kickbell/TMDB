////
////  MoviesServiceMock.swift
////  TMDBTests
////
////  Created by jc.kim on 3/8/23.
////
//
//import Foundation
//@testable import TMDB
//
//class MoviesServiceMock: MoviesServiceType {
//    
//    var responses = [String:Any]()
//    let target = MovieDetail.loadFromFile("MovieDetails.json", MovieDetailRequestTests.self)
//    
//    init() {
//        responses[String(describing: target.self)] = target
//    }
//
//    func popular() async -> Result<Movies, NetworkError> {
//        <#code#>
//    }
//    
//    func topRated() async -> Result<Movies, NetworkError> {
//        <#code#>
//    }
//    
//    func upcoming() async -> Result<Movies, NetworkError> {
//        <#code#>
//    }
//    
//    func genre() async -> Result<Genres, NetworkError> {
//        <#code#>
//    }
//    
//    func search(query: String, page: Int) async -> Result<Movies, NetworkError> {
//        <#code#>
//    }
//    
//    
//    var movieDetailCallCount = 0
//    var movieDetailLastTitle: String?
//    var movieDetailLastReturnValue: Result<MovieDetail, NetworkError>!
//    var movieDetailLastClosure: ((Int) -> Result<MovieDetail, NetworkError>)?
//    
//    
//    func detail(id: Int) async -> Result<MovieDetail, NetworkError> {
//        movieDetailCallCount += 1
//        return movieDetailLastClosure.map { $0(id) } ?? movieDetailLastReturnValue
//    }
//    
//    func trending() async -> Result<Movies, NetworkError> {
//        <#code#>
//    }
//    
//
//}
