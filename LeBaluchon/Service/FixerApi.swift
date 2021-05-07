//
//  FixerApi.swift
//  LeBaluchon
//
//  Created by Manon Russo on 13/04/2021.
//

import Foundation

final class FixerApi: ServiceDecoder {
    static let shared = FixerApi()
    private var task: URLSessionDataTask?
    private var urlSession: URLSession = URLSession(configuration: .default)
    private override init() {}
    
    init(urlSession: URLSession) {
        self.urlSession = urlSession
    }
    
    private let stringUrl = "http://data.fixer.io/api/latest?access_key=\(APIKey.fixerApiKey)"
    
    func fetchCurrencyData(completion: @escaping (Result<RateInfo, ServiceError>) -> Void) {
        guard let fixerUrl = URL(string: stringUrl) else { return completion(.failure(.invalidUrl)) }
        // If a task is already ongoing, we're canceling it before creating a new one (secured on UI with activity indicator).
        task?.cancel()
        task = urlSession.dataTask(with: fixerUrl) { (data, response, error) in
            let result = self.handleResponse(dataType: RateInfo.self, data, response, error)
            completion(result)
        }
        task?.resume() // This method start the task previously defined (newly initialized task begin in a suspended state).
    }
    
}
