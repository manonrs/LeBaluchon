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
        weatherService.fetchWeatherDataFor(WeatherId.lyon.cityID) { (result) in
            guard case .failure(let error) = result else {
                XCTFail("Test request method with an error failed.")
                return
            }
            XCTAssertNotNil(error)
            //XCTAssert(error.localizedDescription)
            //XCTAssertEqual(error.localizedDescription, serviceError.invalidUrl.localizedDescription)

        }
    }
    
    func testGetWeatherShouldPostFailedCompletionIfNoData() throws {
        // Given:
        let weatherService = OpenWeatherAPI (
            urlSession: URLSessionFake(data: nil, response: nil, error: nil))
        
        // When:
        weatherService.fetchWeatherDataFor(WeatherId.lyon.cityID) { (result) in
            // Then:
            guard case .failure(let error) = result else {
                XCTFail("Test request method with an error failed.")
                return
            }
            XCTAssertNotNil(error)
        }
    }
    
    func testGetWeatherShouldPostFailedCompletionIfIncorrectResponse() throws {
        // Given:
        let weatherService = OpenWeatherAPI (
            urlSession: URLSessionFake(data: FakeReponseData.correctData("OpenWeather"), response: FakeReponseData.responseK0, error: nil))
        
        // When:
        weatherService.fetchWeatherDataFor(WeatherId.lyon.cityID) { (result) in
            // Then:
            guard case .failure(let error) = result else {
                XCTFail("Test request method with an error failed.")
                return
            }
            XCTAssertNotNil(error)
        }
    }
    
    func testGetWeatherShouldPostFailedCompletionIfIncorrectData() throws {
        // Given:
        let weatherService = OpenWeatherAPI (
            urlSession: URLSessionFake(data: FakeReponseData.incorrectData, response: FakeReponseData.responseOK, error: nil))
        
        // When:
        weatherService.fetchWeatherDataFor(WeatherId.lyon.cityID) { (result) in
            // Then:
            guard case .failure(let error) = result else {
                XCTFail("Test request method with an error failed.")
                return
            }
            XCTAssertNotNil(error)
        }
    }
    
    func testGetWeatherShouldPostSuccessCompletionIfNoErrorAndCorrectData() throws {
        // Given:
        let weatherService = OpenWeatherAPI (
            urlSession: URLSessionFake(data: FakeReponseData.correctData("OpenWeather"), response: FakeReponseData.responseOK, error: nil))
        
        // When:
        weatherService.fetchWeatherDataFor(WeatherId.lyon.cityID) { (result) in
            // Then:
            guard case .success(let success) = result else {
                XCTFail("Test request method with an error failed.")
                return
            }
            let id = Float(800.5)
            let temp = Float(7.92)
            let icon = "01d"
            let name = "New York"
            let description = "ciel dégagé"
            XCTAssertNotNil(success)
            XCTAssertEqual(success.name, name)
            XCTAssertEqual(description, success.weather[0].description)
            XCTAssertEqual(icon, success.weather[0].icon)
            XCTAssertEqual(id, success.weather[0].id)
            XCTAssertEqual(temp, success.main.temp)
        }
    }
    
}
