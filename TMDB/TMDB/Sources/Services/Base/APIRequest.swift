//
//  APIRequest.swift
//  TMDB
//
//  Created by jc.kim on 3/7/23.
//

import Foundation

protocol APIRequest {
    associatedtype RequestDataType
    associatedtype ResponseDataType
    
    func makeRequest(from endpoint: RequestDataType) throws -> URLRequest
    func parseResponse(data: Data) throws -> ResponseDataType
}


