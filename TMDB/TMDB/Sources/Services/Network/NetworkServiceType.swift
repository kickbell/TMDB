//
//  NetworkServiceType.swift
//  TMDB
//
//  Created by jc.kim on 3/9/23.
//

import Foundation

protocol NetworkServiceType: AnyObject {
    func load<T: APIRequest>(_ request: T, _ requestData: T.RequestDataType) async -> Result<T.ResponseDataType, NetworkError>
}

enum NetworkError: Error, CustomStringConvertible {
    case decode
    case invalidURL
    case invalidRequest
    case noResponse
    case unauthorized
    case unexpectedStatusCode
    case unknown
    
    var description: String {
        switch self {
        case .decode: return "decode"
        case .invalidURL: return "invalidURL"
        case .invalidRequest: return "invalidRequest"
        case .noResponse: return "noResponse"
        case .unauthorized: return "unauthorized"
        case .unexpectedStatusCode: return "unexpectedStatusCode"
        case .unknown: return "unknown"
        }
    }
}
