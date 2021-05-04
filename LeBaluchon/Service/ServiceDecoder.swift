//
//  HandleResponseDelegate.swift
//  LeBaluchon
//
//  Created by Manon Russo on 21/04/2021.
//

import Foundation
// TODO: Faire un protocole qui implémente cette méthode, avec une implémentation par défaut, juste conformer les fichiers au protocole pour accéder à la méthode handleResponse()

class ServiceDecoder {
    func handleResponse<T>(dataType: T.Type, _ data: Data?, _ response: URLResponse?, _ error: Error?) -> Result<T, ServiceError> where T:Decodable {
        if let error = error {
            return .failure(.errorFromAPI(error.localizedDescription))
        }
        
        guard let response = response as? HTTPURLResponse else {
            return .failure(.invalidResponse)
        }
        
        guard response.statusCode == 200 else {
            return .failure(.invalidStatusCode)
        }
        
        guard let data = data else {
            return .failure(.errorEmptyData)
        }
        do {
            let decodedData = try JSONDecoder().decode(dataType, from: data)
            return .success(decodedData)
        } catch let error {
            print(error)
            return .failure(.decodingError)
        }
    }
}
