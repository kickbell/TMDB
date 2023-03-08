//
//  APIRequestLoaderMock.swift
//  TMDBTests
//
//  Created by jc.kim on 3/8/23.
//

import Foundation
@testable import TMDB

class APIRequestLoaderMock: APIRequestLoaderType {
    
    var loadCallsCount = 0
    
    var responses = [String:Any]()
    
    func load<T>(_ endpoint: MoviesEndpoint) -> Result<T, NetworkError> {
        if let response = responses[endpoint.path] as? T {
            return .success(response)
        } else if let error = responses[endpoint.path] as? NetworkError {
            return .failure(error)
        } else {
            return .failure(NetworkError.invalidURL)
        }
    }
    
            
    //이걸 건드려야되나..?
    //하고자하는것..
    
    //loadAPIRequest 이것을 타면 네트워크를 타지않고, 강제적으로 Result<T, NetworkError>같은 타입으로
    //리턴을 해주고 싶은 상황임.
    //그래야 테스트를 할 수 있을 테니까.
    //이걸 다 뜯어고쳐야하나 ..?

}
