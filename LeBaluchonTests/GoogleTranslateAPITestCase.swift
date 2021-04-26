//
//  GoogleTranslateAPITestCase.swift
//  LeBaluchonTests
//
//  Created by Manon Russo on 23/04/2021.
//

import XCTest
@testable import LeBaluchon

class GoogleAPITestCase: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        
    }

    func testGetTranslationShouldPostFailedCompletionIfError() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
     //Given:
        let translateService = GoogleTranslateAPI (
            urlSession: URLSessionFake(data: nil, response: nil, error: FakeReponseData.error))
        //When:
        translateService.fetchTranslationData("bonjour") { (result) in
            //Then:
            guard case .failure(let error) = result else {
                XCTFail("Test request method with an error failed.")
                return
            }
            XCTAssertNotNil(error)
        }
    }

    func testGetTranslationShouldPostFailedCompletionIfNoData() throws {
        // Given:
        let translateService = GoogleTranslateAPI (
            urlSession: URLSessionFake(data: nil, response: nil, error: nil))
        
        // When:
        translateService.fetchTranslationData("bonjour") { (result) in
            // Then:
            guard case .failure(let error) = result else {
                XCTFail("Test request method with an error failed.")
                return
            }
            XCTAssertNotNil(error)
        }
    }
    
    func testGetTranslationShouldPostFailedCompletionIfIncorrectResponse() throws {
        // Given:
        let translateService = GoogleTranslateAPI (
            urlSession: URLSessionFake(data: FakeReponseData.googleCorrectData, response: FakeReponseData.responseK0, error: nil))
        
        // When:
        translateService.fetchTranslationData("bonjour") { (result) in
            // Then:
            guard case .failure(let error) = result else {
                XCTFail("Test request method with an error failed.")
                return
            }
            XCTAssertNotNil(error)
        }
    }
    
    func testGetTranslationShouldPostFailedCompletionIfIncorrectData() throws {
        // Given:
        let translateService = GoogleTranslateAPI (
            urlSession: URLSessionFake(data: FakeReponseData.incorrectData, response: FakeReponseData.responseOK, error: nil))
        
        // When:
        translateService.fetchTranslationData("bonjour") { (result) in
            // Then:
            guard case .failure(let error) = result else {
                XCTFail("Test request method with an error failed.")
                return
            }
            XCTAssertNotNil(error)
        }
    }
    
    func testGetTranslationShouldPostSuccessCompletionIfNoErrorAndCorrectData() throws {
        // Given:
        let translateService = GoogleTranslateAPI (
            urlSession: URLSessionFake(data: FakeReponseData.googleCorrectData, response: FakeReponseData.responseOK, error: nil))
        
        // When:
        translateService.fetchTranslationData("bonjour") { (result) in
            // Then:
            let translatedText =  "Hello"
            guard case .success(let success) = result else {
                XCTFail("Test request method with an error failed.")
                return
            }
            XCTAssertNotNil(success)
            XCTAssertEqual(translatedText, success.data.translations[0].translatedText)
        }
    }
    
}
