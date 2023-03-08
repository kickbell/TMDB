//
//  MoviesService.swift
//  TMDB
//
//  Created by jc.kim on 2/19/23.
//

import Foundation

final class MoviesService: MoviesServiceType {
    private let networkService: NetworkServiceType
    private let imageLoaderService: ImageLoaderServiceType

    init(networkService: NetworkServiceType = NetworkService(),
         imageLoaderService: ImageLoaderServiceType = ImageLoaderService()) {
        self.networkService = networkService
        self.imageLoaderService = imageLoaderService
    }
    
    func popular() async -> Result<Movies, NetworkError> {
        return await networkService.load(MoviesRequest(), MoviesEndpoint.popular)
    }
    
    func topRated() async -> Result<Movies, NetworkError> {
        return await networkService.load(MoviesRequest(), MoviesEndpoint.topRated)
    }
    
    func upcoming() async -> Result<Movies, NetworkError> {
        return await networkService.load(MoviesRequest(), MoviesEndpoint.upcomming)
    }
    
    func genre() async -> Result<Genres, NetworkError> {
        return await networkService.load(GenresRequest(), MoviesEndpoint.genre)
    }

    func search(query: String, page: Int) async -> Result<Movies, NetworkError> {
        return await networkService.load(MoviesRequest(), MoviesEndpoint.search(query: query, page: page))
    }
    
    func detail(id: Int) async -> Result<MovieDetail, NetworkError> {
        return await networkService.load(MovieDetailRequest(), MoviesEndpoint.movieDetail(id: id))
    }
    
    func trending() async -> Result<Movies, NetworkError> {
        return await networkService.load(MoviesRequest(), MoviesEndpoint.trending)
    }
}
