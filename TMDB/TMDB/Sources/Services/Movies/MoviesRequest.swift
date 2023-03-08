//
//  MoviesRequest.swift
//  TMDB
//
//  Created by jc.kim on 3/7/23.
//

import Foundation

struct MoviesRequest: APIRequest {
    func makeRequest(from endpoint: MoviesEndpoint) throws -> URLRequest {
        var urlComponents = URLComponents()
        urlComponents.scheme = endpoint.scheme
        urlComponents.host = endpoint.host
        urlComponents.path = endpoint.path
        urlComponents.queryItems = endpoint.queryItems
        
        guard let url = urlComponents.url else {
            throw NetworkError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue
        request.allHTTPHeaderFields = endpoint.header

        if let body = endpoint.body {
            request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: [])
        }
        
        return request
    }
    
    func parseResponse(data: Data) throws -> Movies {
        return try JSONDecoder().decode(Movies.self, from: data)
    }
}

