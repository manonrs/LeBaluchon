//
//  GoogleTranslateAPI.swift
//  LeBaluchon
//
//  Created by Manon Russo on 16/04/2021.

import Foundation

final class GoogleTranslateAPI: ServiceDecoder {
    static let shared = GoogleTranslateAPI()
    private var task: URLSessionDataTask?
    private var urlSession: URLSession = URLSession(configuration: .default)
    private override init() {}
    init(urlSession: URLSession) {
        self.urlSession = urlSession
    }
    
    private func loadTextToTranslate (_ text: String) -> String {
        let stringUrl = "https://translation.googleapis.com/language/translate/v2?key=\(APIKey.googleApiKey)&target=en&q=\(text)&source=fr"
        return stringUrl
    }

    func fetchTranslationData(_ text: String, completion: @escaping(Result<TranslationInfo, ServiceError>) -> Void) {
        guard let googleUrl = URL(string: loadTextToTranslate(text).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!) else { return completion(.failure(.invalidUrl)) }
        // If a task is already ongoing, we're canceling it before creating a new one (secured on UI with activity indicator).
        task?.cancel()
        task = urlSession.dataTask(with: googleUrl) { (data, response, error) in
            let result = self.handleResponse(dataType: TranslationInfo.self, data, response, error)
            completion(result)
        }
        task?.resume() // This method start the task previously defined (newly initialized task begin in a suspended state).
    }
}
