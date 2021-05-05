//
//  FixerApi.swift
//  LeBaluchon
//
//  Created by Manon Russo on 13/04/2021.
//

import Foundation

class FixerApi: ServiceDecoder {
    static let shared = FixerApi()
    private var task: URLSessionDataTask?
    private var urlSession: URLSession = URLSession(configuration: .default)
    private override init() {}
    
    init(urlSession: URLSession) {
        self.urlSession = urlSession
    }
    
    let stringUrl = "http://data.fixer.io/api/latest?access_key=\(APIKey.fixerApiKey)"
    
    func fetchCurrencyData(completion: @escaping (Result<RateInfo, ServiceError>) -> Void) {
        guard let fixerUrl = URL(string: stringUrl) else { return completion(.failure(.invalidUrl)) }

        task?.cancel()
        task = urlSession.dataTask(with: fixerUrl, completionHandler: { (data, response, error) in
            let result = self.handleResponse(dataType: RateInfo.self, data, response, error)
            completion(result)
        })

        task?.resume()
        
        print("Fixer url: \(fixerUrl)")
    }
    
}
