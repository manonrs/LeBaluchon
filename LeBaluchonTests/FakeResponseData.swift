//
//  FakeResponseData.swift
//  LeBaluchonTests
//
//  Created by Manon Russo on 22/04/2021.
//

import Foundation

class FakeReponseData {
    let responseOK = HTTPURLResponse(url: URL(string:"https://google.com")!,
                                     statusCode: 200, httpVersion: nil, headerFields: nil)!
    let responseK0 = HTTPURLResponse(url: URL(string:"https://google.com")!,
                                     statusCode: 500, httpVersion: nil, headerFields: nil)!
    
    class FakeError: Error {}
    static let error = FakeError()
    
    var fixerCorrectData: Data {
        let bundle = Bundle(for: FakeReponseData.self)
        let url = bundle.url(forResource: "Fixer", withExtension: "json")
        let data = try! Data(contentsOf: url!)
        return data
    }
        
    var openWeatherCorrectData: Data {
        let bundle = Bundle(for: FakeReponseData.self)
        let url = bundle.url(forResource: "OpenWeather", withExtension: "json")
        let data = try! Data(contentsOf: url!)
        return data
    }
    
    var unsplashCorrectData: Data {
        let bundle = Bundle(for: FakeReponseData.self)
        let url = bundle.url(forResource: "Unsplash", withExtension: "json")
        let data = try! Data(contentsOf: url!)
        return data
    }
    
    var googleCorrectData: Data {
        let bundle = Bundle(for: FakeReponseData.self)
        let url = bundle.url(forResource: "Google", withExtension: "json")
        let data = try! Data(contentsOf: url!)
        return data
    }
    
    let incorrectData = "erreur".data(using: .utf8)!
}
