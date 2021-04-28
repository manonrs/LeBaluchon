//
//  FixerApi.swift
//  LeBaluchon
//
//  Created by Manon Russo on 13/04/2021.
//

import Foundation

class FixerApi: HandleResponseDelegate {
    private var task: URLSessionDataTask?
    private var urlSession: URLSession
    init(urlSession: URLSession = URLSession(configuration: .default)) {
        self.urlSession = urlSession
    }
    
    
//    let stringUrl = "http://data.fixer.io/api/latest?access_key=bdb9201595f1b3549bb51ffcfd8d7b4a"
    let stringUrl = "http://data.fixer.io/api/latest?access_key=\(APIKey.fixerApiKey)"
    
    func fetchCurrencyData(completion: @escaping (Result<RateInfo, ServiceError>) -> Void) {
        guard let fixerUrl = URL(string: stringUrl) else { return completion(.failure(.invalidUrl)) }

        task?.cancel()
        task = urlSession.dataTask(with: fixerUrl, completionHandler: { (data, response, error) in
            let result = self.handleResponse(dataType: RateInfo.self, data, response, error)
            completion(result)
        })

        task?.resume()
        
        print("\(fixerUrl)")
    }
    
}
