//
//  MoviesService.swift
//  TMDB
//
//  Created by jc.kim on 2/19/23.
//

import Foundation


final class MoviesService: MoviesServiceType {
    private let moviesLoader: APIRequestLoader<MoviesRequest>
    private let genresLoader: APIRequestLoader<GenresRequest>
    private let movieDetailLoader: APIRequestLoader<MovieDetailRequest>
    
    init(_ movies: APIRequestLoader<MoviesRequest> = .init(apiRequest: MoviesRequest()),
         _ genres: APIRequestLoader<GenresRequest> = .init(apiRequest: GenresRequest()),
         _ movieDetail: APIRequestLoader<MovieDetailRequest> = .init(apiRequest: MovieDetailRequest())
    ) {
        self.moviesLoader = movies
        self.genresLoader = genres
        self.movieDetailLoader = movieDetail
    }
    
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
