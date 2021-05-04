//
//  GoogleTranslateAPI.swift
//  LeBaluchon
//
//  Created by Manon Russo on 16/04/2021.

import Foundation

class GoogleTranslateAPI: ServiceDecoder {

    private var task: URLSessionDataTask?
    private var urlSession: URLSession
    init(urlSession: URLSession = URLSession(configuration: .default)) {
        self.urlSession = urlSession
    }
    
    func loadTextToTranslate (_ text: String) -> String {
        let stringUrl = "https://translation.googleapis.com/language/translate/v2?key=\(APIKey.googleApiKey)&target=en&q=\(text)&source=fr"
        return stringUrl
    }

    func fetchTranslationData(_ text: String, completion: @escaping(Result<TranslationInfo, ServiceError>) -> Void) {
        guard let googleUrl = URL(string: loadTextToTranslate(text).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!) else {
            return completion(.failure(.invalidUrl))
            
        }
        task?.cancel()
        task = urlSession.dataTask(with: googleUrl, completionHandler: { (data, response, error) in
            let result = self.handleResponse(dataType: TranslationInfo.self, data, response, error)
            completion(result)
        })
        task?.resume()
    }

}
