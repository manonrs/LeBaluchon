//
//  OpenWeatherAPI.swift
//  LeBaluchon
//
//  Created by Manon Russo on 09/04/2021.
//

import UIKit

final class OpenWeatherAPI: ServiceDecoder {
    static let shared = OpenWeatherAPI()

    private var task: URLSessionDataTask?
    private var urlSession: URLSession = URLSession(configuration: .default)
    private override init() {}

    init(urlSession: URLSession) {
        self.urlSession = urlSession
    }

    private func loadCity(_ cityId: String) -> String {
        let stringUrl = "https://api.openweathermap.org/data/2.5/weather?id=\(cityId)&appid=\(APIKey.weatherApiKey)&units=metric&lang=fr"
        return stringUrl
    }
    
    func fetchWeatherDataFor(_ cityId: String, completion: @escaping (Result<MainWeatherInfo, ServiceError>) -> Void) {
        guard let openWeatherUrl = URL(string: loadCity(cityId)) else { return completion(.failure(.invalidUrl)) }
        // If a task is already ongoing, we're canceling it before creating a new one (secured on UI with activity indicator).
        task?.cancel()
        task = urlSession.dataTask(with: openWeatherUrl) { (data, response, error) in
            let result = self.handleResponse(dataType: MainWeatherInfo.self, data, response, error)
            completion(result)
        }
        task?.resume() // This method start the task previously defined (newly initialized task begin in a suspended state).
    }
}
