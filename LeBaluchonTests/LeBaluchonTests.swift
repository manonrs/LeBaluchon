//
//  LeBaluchonTests.swift
//  LeBaluchonTests
//
//  Created by Manon Russo on 09/04/2021.
//

import XCTest
@testable import LeBaluchon

class LeBaluchonTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

}

class URLSessionFake: URLSession {
//    init(data: Data?, response: URLResponse?, error: Error?) {
//        self.data = data
//    }
    override func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        <#code#>
    }
}
