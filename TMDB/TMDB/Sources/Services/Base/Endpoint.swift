//
//  Endpoint.swift
//  TMDB
//
//  Created by jc.kim on 2/19/23.
//

import Foundation

protocol Endpoint {
    var scheme: String { get }
    var host: String { get }
    var path: String { get }
    var method: HttpMethod { get }
    var header: [String: String]? { get }
    var body: [String: String]? { get }
    var queryItems: [URLQueryItem] { get }
}

extension Endpoint {
    var scheme: String {
    #if UITESTING
        return "http"
    #else
        return "https"
    #endif
    }
    
    var host: String {
    #if UITESTING
        return "localhost:8080"
    #else
        return "api.themoviedb.org"
    #endif
    }
}
