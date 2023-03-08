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



//@testable은 unit테스트에서만

/*
 Unit Test
 화이트박스 테스트
 소프트웨어 혹은 제품의 내부 구조, 동작을 세밀하게 검사하는 테스트 방식으로, 외부에서 요구사항에 따른 예상 결과값을 테스트 하는 것과는 다르게 내부 소스 코드를 테스트하는 기법으로 사용자가 들여다 볼 수 없는 구간의 코드 단위를 테스트 한다.
 즉, 정리하면 개발자가 소프트웨어 또는 컴포넌트 등의 로직에 대한 테스트를 수행하기 위해 설계 단계에서 요구된 사항을 확인하는 개발자 관점의 단위테스팅 기법이다.
 
 
 UI TEst
 블랙박스 테스트
 소프트웨어의 내부 구조나 작동 원리를 모르는 상태에서 소프트웨어의 동작을 검사하는 방법.
 
 
 
 블랙 박스 테스팅 에서는 테스트 대상의 내부가 어떻게 작동하는지 신경 쓰지 않습니다. 노출된 API를 호출하고 결과를 확인합니다. 테스트 대상이 결과를 제공하기 위해 무엇을 했는지는 신경 쓰지 않습니다.

 화이트 박스 테스트 에서는 테스트 중인 항목의 내부가 어떻게 작동하는지 신경을 씁니다 . 따라서 사물의 출력을 확인하는 대신 테스트 중인 사물의 내부 변수가 올바른지 확인할 수 있습니다.
 */

//class TMDBUITests: XCTestCase {
//
//
//    func testExample() throws {
//
//        let movies = Movies.loadFromFile("Movies.json")
//        print(movies)
//        // Use XCTAssert and related functions to verify your tests produce the correct results.
//    }
//
//}



