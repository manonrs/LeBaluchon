//
//  FixerApi.swift
//  LeBaluchon
//
//  Created by Manon Russo on 13/04/2021.
//

import Foundation

class FixerApi: HandleResponseDelegate {
    
    let stringUrl = "http://data.fixer.io/api/latest?access_key=bdb9201595f1b3549bb51ffcfd8d7b4a"
    
    func fetchCurrencyData(completion: @escaping (Result<RateInfo, ServiceError>) -> Void) {
        guard let fixerUrl = URL(string: stringUrl) else { return completion(.failure(.invalidUrl)) }
        
        URLSession.shared.dataTask(with: fixerUrl, completionHandler: { (data, response, error) in
            let result = self.handleResponse(dataType: RateInfo.self, data, response, error)
            completion(result)
        }).resume()
        
        print("\(fixerUrl)")
    }
    
}

