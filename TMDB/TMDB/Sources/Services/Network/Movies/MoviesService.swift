//
//  MoviesService.swift
//  TMDB
//
//  Created by jc.kim on 2/19/23.
//

import Foundation


final class MoviesService: MoviesServiceType {
    private let moviesLoader = APIRequestLoader.init(apiRequest: MoviesRequest())
    private let genresLoader = APIRequestLoader.init(apiRequest: GenresRequest())
    private let movieDetailLoader = APIRequestLoader.init(apiRequest: MovieDetailRequest())
    
    func popular() async -> Result<Movies, NetworkError> {
        return await moviesLoader.loadAPIRequest(requestData: MoviesEndpoint.popular)
    }
    
    func topRated() async -> Result<Movies, NetworkError> {
        return await moviesLoader.loadAPIRequest(requestData: MoviesEndpoint.popular)
    }
    
    func upcoming() async -> Result<Movies, NetworkError> {
        return await moviesLoader.loadAPIRequest(requestData: MoviesEndpoint.upcomming)
    }
    
    func genre() async -> Result<Genres, NetworkError> {
        return await genresLoader.loadAPIRequest(requestData: MoviesEndpoint.genre)
    }

    func search(query: String, page: Int) async -> Result<Movies, NetworkError> {
        return await moviesLoader.loadAPIRequest(requestData: MoviesEndpoint.search(query: query, page: page))
    }
    
    func detail(id: Int) async -> Result<MovieDetail, NetworkError> {
        return await movieDetailLoader.loadAPIRequest(requestData: MoviesEndpoint.movieDetail(id: id))
    }
    
    func trending() async -> Result<Movies, NetworkError> {
        return await moviesLoader.loadAPIRequest(requestData: MoviesEndpoint.trending)
    }
}
