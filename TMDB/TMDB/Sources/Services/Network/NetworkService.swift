//
//  NetworkService.swift
//  TMDB
//
//  Created by jc.kim on 3/9/23.
//

import Foundation

final class NetworkService: NetworkServiceType {
    private let session: URLSession

    
    
//#if UITESTING
//let config = URLSessionConfiguration.default
//#else
//let config = URLSessionConfiguration.ephemeral
//#endif
//let session = URLSession(configuration: config)
//        return session
    
    
    
    init(session: URLSession = URLSession(configuration: URLSessionConfiguration.default)) {
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
