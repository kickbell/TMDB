//
//  TMDBUITests.swift
//  TMDBUITests
//
//  Created by jc.kim on 3/4/23.
//

import XCTest

extension Decodable {
    static func loadFromFile(_ filename: String,_ type: AnyClass) -> Self {
        do {
            let path = Bundle(for: type).path(forResource: filename, ofType: nil)!
            let data = try Data(contentsOf: URL(fileURLWithPath: path))
            return try JSONDecoder().decode(Self.self, from: data)
        } catch {
            fatalError("Error: \(error.localizedDescription)")
        }
    }
    
    static func loadDataFromFile(_ filename: String,_ type: AnyClass) -> Data {
        do {
            let path = Bundle(for: type).path(forResource: filename, ofType: nil)!
            return try Data(contentsOf: URL(fileURLWithPath: path))
        } catch {
            fatalError("Error: \(error.localizedDescription)")
        }
    }
}


