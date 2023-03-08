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

protocol NetworkServiceType: AnyObject {
    func load<T: APIRequest>(_ request: T, _ requestData: T.RequestDataType) async -> Result<T.ResponseDataType, NetworkError>
}

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

final class NetworkService: NetworkServiceType {
    private let session: URLSession

    init(session: URLSession = URLSession.shared) {
        self.session = session
    }

    func load<T: APIRequest>(_ request: T, _ requestData: T.RequestDataType) async -> Result<T.ResponseDataType, NetworkError> {
        do {
            let urlRequest = try request.makeRequest(from: requestData)
            
            let (data, response) = try await session.data(for: urlRequest, delegate: nil)
            guard let response = response as? HTTPURLResponse else {
                return .failure(.noResponse)
            }
            switch response.statusCode {
            case 200...299:
                guard let parsedResponse = try? request.parseResponse(data: data) else {
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

class APIRequestLoader<T: APIRequest> {
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

