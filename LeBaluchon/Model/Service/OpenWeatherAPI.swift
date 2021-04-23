//
//  OpenWeatherAPI.swift
//  LeBaluchon
//
//  Created by Manon Russo on 09/04/2021.
//

import UIKit

class OpenWeatherAPI: HandleResponseDelegate {
    
    private var task: URLSessionDataTask?
    private var urlSession: URLSession
    init(urlSession: URLSession = URLSession(configuration: .default)) {
        self.urlSession = urlSession
    }
    
    //    Créer Enum config(weather(avec lyonId et nyId dedans); currency) + à part une enum APIKey static let apiKey
    //    Config.Weather.apikey
    let lyonID = "2996944"
    let nyId = "5128581"
    
    func loadCity(_ cityId: String) -> String {
        let stringUrl = "https://api.openweathermap.org/data/2.5/weather?id=\(cityId)&appid=2f4240e158347092c4e7a70e148d6ed8&units=metric&lang=fr"
        return stringUrl
    }
    
    func fetchWeatherDataFor(_ cityId: String, completion: @escaping (Result<MainWeatherInfo, ServiceError>) -> Void) {
        
        guard let openWeatherUrl = URL(string: loadCity(cityId)) else { return completion(.failure(.invalidUrl)) }
        task?.cancel()
        
        task = urlSession.dataTask(with: openWeatherUrl, completionHandler: { (data, response, error) in
            
            let result = self.handleResponse(dataType: MainWeatherInfo.self, data, response, error)
            completion(result)
        })/*.resume()*/
        task?.resume()
        print("\(openWeatherUrl)")
    }
}
