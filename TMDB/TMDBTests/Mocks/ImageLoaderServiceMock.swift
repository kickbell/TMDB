//
//  ImageLoaderServiceMock.swift
//  TMDBTests
//
//  Created by jc.kim on 3/9/23.
//

import Foundation
@testable import TMDB
import UIKit

class ImageLoaderServiceMock: ImageLoaderServiceType {
    var loadImageFromCallsCount = 0

    func loadImage(from url: URL, completion: @escaping (Result<UIImage?, Never>) -> Void) {
        completion(.success(UIImage()))
    }
}
