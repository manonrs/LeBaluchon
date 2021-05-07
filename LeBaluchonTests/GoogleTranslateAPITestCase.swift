//
//  GoogleTranslateAPITestCase.swift
//  LeBaluchonTests
//
//  Created by Manon Russo on 23/04/2021.
//

import XCTest
@testable import LeBaluchon

class GoogleAPITestCase: XCTestCase {
    func testGetTranslationShouldPostFailedCompletionIfError() throws {
     //Given:
        let translateService = GoogleTranslateAPI (
            urlSession: URLSessionFake(data: nil, response: nil, error: FakeReponseData.error))
        //When:
        translateService.fetchTranslationData("bonjour") { (result) in
            //Then:
            guard case .failure(let error) = result else {
                XCTFail("Test request method with an error (FakeError) failed.")
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
                XCTFail("Test request method with an error (no data) failed.")
                return
            }
            XCTAssertNotNil(error)
        }
    }
    
    func testGetTranslationShouldPostFailedCompletionIfIncorrectResponse() throws {
        // Given:
        let translateService = GoogleTranslateAPI (
            urlSession: URLSessionFake(data: FakeReponseData.correctData("Google"), response: FakeReponseData.responseK0, error: nil))
        
        // When:
        translateService.fetchTranslationData("bonjour") { (result) in
            // Then:
            guard case .failure(let error) = result else {
                XCTFail("Test request method with an error (incorrect reponse) failed.")
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
                XCTFail("Test request method with an error (incorrect data) failed.")
                return
            }
            XCTAssertNotNil(error)
        }
    }
    
    func testGetTranslationShouldPostSuccessCompletionIfNoErrorAndCorrectData() throws {
        // Given:
        let translateService = GoogleTranslateAPI (
            urlSession: URLSessionFake(data: FakeReponseData.correctData("Google"), response: FakeReponseData.responseOK, error: nil))
        // When:
        translateService.fetchTranslationData("bonjour") { (result) in
            // Then:
            let translatedText =  "Hello"
            guard case .success(let success) = result else {
                XCTFail("Test request method with data failed.")
                return
            }
            XCTAssertNotNil(success)
            XCTAssertEqual(success.data.translations[0].translatedText, translatedText)
        }
    }
    
}
