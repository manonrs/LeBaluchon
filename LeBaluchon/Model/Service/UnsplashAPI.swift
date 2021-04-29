//
//  UnsplashAPI.swift
//  LeBaluchon
//
//  Created by Manon Russo on 15/04/2021.
//

import Foundation

class UnsplashAPI: HandleResponseDelegate {
//    let lyonAlbumId = "426804"
//    let lyonAlbumId = "21328203"
//    let nyAlbumId = "3541178"
    
    private var task: URLSessionDataTask?
    private var urlSession: URLSession
    init(urlSession: URLSession = URLSession(configuration: .default)) {
        self.urlSession = urlSession
    }
    
    func loadCityID (_ collectionsID: String) -> String {
        let stringUrl = "https://api.unsplash.com/collections/\(collectionsID)/photos/?client_id=\(APIKey.unsplashApiKey)"
        return stringUrl
    }
    
    func fetchPhotoDataFor(_ collectionsID: String, completion: @escaping (Result<[PhotosInfo], ServiceError>) -> Void) {
        guard let unsplashUrl = URL(string: loadCityID(collectionsID)) else {
            return completion(.failure(.invalidUrl))
        }
        task?.cancel()
        task = urlSession.dataTask(with: unsplashUrl, completionHandler: { (data, response, error) in
            let result = self.handleResponse(dataType: [PhotosInfo].self, data, response, error)
            completion(result)
            
        })
        task?.resume()
        print("picture url : \(unsplashUrl)")
    }
    
}
