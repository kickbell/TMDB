//
//  MoviesServiceType.swift
//  TMDB
//
//  Created by jc.kim on 2/19/23.
//

import Foundation

protocol MoviesServiceType: AnyObject {
    func popular() async -> Result<Movies, NetworkError>
    func topRated() async -> Result<Movies, NetworkError>
    func upcoming() async -> Result<Movies, NetworkError>
    func genre() async -> Result<Genres, NetworkError>
    func search(query: String, page: Int) async -> Result<Movies, NetworkError>
    func detail(id: Int) async -> Result<MovieDetail, NetworkError>
    func trending() async -> Result<Movies, NetworkError>
}

