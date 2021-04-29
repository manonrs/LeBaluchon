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

    func loadCity(_ cityId: String) -> String {
        let stringUrl = "https://api.openweathermap.org/data/2.5/weather?id=\(cityId)&appid=\(APIKey.weatherApiKey)&units=metric&lang=fr"
        return stringUrl
    }
    
    func fetchWeatherDataFor(_ cityId: String, completion: @escaping (Result<MainWeatherInfo, ServiceError>) -> Void) {
        
        guard let openWeatherUrl = URL(string: loadCity(cityId)) else { return completion(.failure(.invalidUrl)) }
        task?.cancel()
        
        task = urlSession.dataTask(with: openWeatherUrl, completionHandler: { (data, response, error) in
            
            let result = self.handleResponse(dataType: MainWeatherInfo.self, data, response, error)
            completion(result)
        })
        task?.resume()
        print("weather URL :\(openWeatherUrl)")
    }
}
