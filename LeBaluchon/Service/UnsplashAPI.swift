//
//  UnsplashAPI.swift
//  LeBaluchon
//
//  Created by Manon Russo on 15/04/2021.
//

import Foundation

final class UnsplashAPI: ServiceDecoder {
    static let shared = UnsplashAPI()
    private var task: URLSessionDataTask?
    private var urlSession: URLSession = URLSession(configuration: .default)
    private override init() {}
    init(urlSession: URLSession ) {
        self.urlSession = urlSession
    }
    
    private func loadCityID (_ collectionsID: String) -> String {
        let stringUrl = "https://api.unsplash.com/collections/\(collectionsID)/photos/?client_id=\(APIKey.unsplashApiKey)"
        return stringUrl
    }
    
    func fetchPhotoDataFor(_ collectionsID: String, completion: @escaping (Result<[PhotosInfo], ServiceError>) -> Void) {
        guard let unsplashUrl = URL(string: loadCityID(collectionsID)) else { return completion(.failure(.invalidUrl)) }
        // If a task is already ongoing, we're canceling it before creating a new one (secured on UI with activity indicator).
        task?.cancel()
        task = urlSession.dataTask(with: unsplashUrl) { (data, response, error) in
            let result = self.handleResponse(dataType: [PhotosInfo].self, data, response, error)
            completion(result)
        }
        task?.resume() // This method start the task previously defined (newly initialized task begin in a suspended state).
    }
    
}
