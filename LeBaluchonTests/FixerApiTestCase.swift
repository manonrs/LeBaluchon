//
//  FixerApiTestCase.swift
//  FixerApiTestCase
//
//  Created by Manon Russo on 09/04/2021.
//

import XCTest
@testable import LeBaluchon

class FixerApiTestCase: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        
    }

    func testGetCurrencyShouldPostFailedCompletionIfError() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
     //Given:
        let currencyService = FixerApi (
            urlSession: URLSessionFake(data: nil, response: nil, error: FakeReponseData.error))
        
        //When:
        currencyService.fetchCurrencyData { (result) in
            //Then:
            guard case .failure(let error) = result else {
                XCTFail("Test request method with an error failed.")
                return
            }
            XCTAssertNotNil(error)
        }
    }

}

