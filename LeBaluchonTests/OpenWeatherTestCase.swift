//
//  OpenWeatherTestCase.swift
//  LeBaluchonTests
//
//  Created by Manon Russo on 23/04/2021.
//

import XCTest
@testable import LeBaluchon

class OpenWeatherTestCase: XCTestCase {
    
    func testGetWeatherShouldPostFailedCompletionIfError() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
     //Given:
        let weatherService = OpenWeatherAPI (
            urlSession: URLSessionFake(data: nil, response: nil, error: FakeReponseData.error))
        
        //When:
        weatherService.fetchWeatherDataFor(weatherService.lyonID) { (result) in
            guard case .failure(let error) = result else {
                XCTFail("Test request method with an error failed.")
                return
            }
            XCTAssertNotNil(error)
        }
    }
    
}
