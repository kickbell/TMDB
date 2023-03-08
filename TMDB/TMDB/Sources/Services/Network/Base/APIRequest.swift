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

protocol APIRequestLoaderType {
//    var loadCallsCount: Int { get }
//    var responses: [String: Any] { get }
//    func load<T>(_ endpoint: MoviesEndpoint) -> Result<T, NetworkError>
}

//1. Mock과 서비스를 묶으려고 한다.
//2. 프로토콜로 해서 기본구현으로 묶으려고 했다.
//3. 근데 변수가 걸리네.

protocol NetworkServiceType {
    func load<T>(_ endpoint: MoviesEndpoint) -> Result<T, NetworkError>
}

//APIRequestLoader를 이걸로 감쌀수있으까.
//final class NetworkService: NetworkServiceType {
//
//}

class APIRequestLoader<T: APIRequest>: APIRequestLoaderType {
    let apiRequest: T
    let urlSession: URLSession
    
    init(apiRequest: T, urlSession: URLSession = .shared) {
        self.apiRequest = apiRequest
        self.urlSession = urlSession
    }
    
    func loadAPIRequest(requestData: T.RequestDataType
    ) async -> Result<T.ResponseDataType, NetworkError> {
        do {
            let request = try apiRequest.makeRequest(from: requestData)
            let (data, response) = try await urlSession.data(for: request, delegate: nil)
            guard let response = response as? HTTPURLResponse else {
                return .failure(.noResponse)
            }
            switch response.statusCode {
            case 200...299:
                guard let parsedResponse = try? self.apiRequest.parseResponse(data: data) else {
                    return .failure(.decode)
                }
                return .success(parsedResponse)
            case 401:
                return .failure(.unauthorized)
            default:
                return .failure(.unexpectedStatusCode)
            }
        } catch {
            return .failure(.unknown)
        }
    }
}

