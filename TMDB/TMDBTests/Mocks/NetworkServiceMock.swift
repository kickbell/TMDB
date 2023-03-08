//
//  NetworkServiceMock.swift
//  TMDBTests
//
//  Created by jc.kim on 3/9/23.
//

import Foundation
@testable import TMDB

final class NetworkServiceMock: NetworkServiceType {
    var loadCallsCount = 0
    var responses = [String:Any]()
    
    func load<T>(_ request: T, _ requestData: T.RequestDataType) async -> Result<T.ResponseDataType, NetworkError> where T : APIRequest {
        do {
            let urlRequest = try request.makeRequest(from: requestData)
            let path = urlRequest.url?.path ?? ""
        
            if let response = responses[path] as? T.ResponseDataType {
                return .success(response)
            } else if let error = responses[path] as? NetworkError {
                return .failure(error)
            } else {
                return .failure(NetworkError.invalidRequest)
            }
        } catch {
            return .failure(NetworkError.invalidRequest)
        }
    }
}
