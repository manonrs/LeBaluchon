//
//  FixerApiTestCase.swift
//  FixerApiTestCase
//
//  Created by Manon Russo on 09/04/2021.
//

import XCTest
@testable import LeBaluchon

class FixerApiTestCase: XCTestCase {
    func testGetCurrencyShouldPostFailedCompletionIfError() throws {
        // Given:
        let currencyService = FixerApi (
            urlSession: URLSessionFake(data: nil, response: nil, error: FakeReponseData.error))
        // When:
        currencyService.fetchCurrencyData { (result) in
            // Then:
            guard case .failure(let error) = result else {
                XCTFail("Test request method with an error failed.")
                return
            }
            XCTAssertNotNil(error)
        }
    }

    func testGetCurrencyShouldPostFailedCompletionIfNoData() throws {
        // Given:
        let currencyService = FixerApi (
            urlSession: URLSessionFake(data: nil, response: nil, error: nil))
        // When:
        currencyService.fetchCurrencyData { (result) in
            // Then:
            guard case .failure(let error) = result else {
                XCTFail("Test request method with an error (no data) failed.")
                return
            }
            XCTAssertNotNil(error)
        }
    }
    
    func testGetCurrencyShouldPostFailedCompletionIfIncorrectResponse() throws {
        // Given:
        let currencyService = FixerApi (
            urlSession: URLSessionFake(data: FakeReponseData.correctData("Fixer"), response: FakeReponseData.responseK0, error: nil))
        // When:
        currencyService.fetchCurrencyData { (result) in
            // Then:
            guard case .failure(let error) = result else {
                XCTFail("Test request method with an error (incorrect response) failed.")
                return
            }
            XCTAssertNotNil(error)
        }
    }
    
    func testGetCurrencyShouldPostFailedCompletionIfIncorrectData() throws {
        // Given:
        let currencyService = FixerApi (
            urlSession: URLSessionFake(data: FakeReponseData.incorrectData, response: FakeReponseData.responseOK, error: nil))
        // When:
        currencyService.fetchCurrencyData { (result) in
            // Then:
            guard case .failure(let error) = result else {
                XCTFail("Test request method with an error (incorrect data) failed.")
                return
            }
            XCTAssertNotNil(error)
        }
    }
    
    func testGetCurrencyShouldPostSuccessCompletionIfNoErrorAndCorrectData() throws {
        // Given:
        let currencyService = FixerApi (
            urlSession: URLSessionFake(data: FakeReponseData.correctData("Fixer"), response: FakeReponseData.responseOK, error: nil))
        // When:
        currencyService.fetchCurrencyData { (result) in
            // Then:
            guard case .success(let success) = result else {
                XCTFail("Test request method with an error (correct data) failed.")
                return
            }
            let base = "EUR"
            let rates = Float(1.202769)
            XCTAssertNotNil(success)
            XCTAssertEqual(success.base, base)
            XCTAssertEqual(success.rates.USD, rates)
            XCTAssertEqual("EUR", base)
        }
    }
    
}

