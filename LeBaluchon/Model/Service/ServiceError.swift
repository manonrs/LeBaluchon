//
//  ServiceError.swift
//  LeBaluchon
//
//  Created by Manon Russo on 16/04/2021.
//

import Foundation

enum ServiceError: Error {
    case invalidResponse
    case errorEmptyData
    case invalidStatusCode
    case errorFromAPI(String)
    case decodingError
    case invalidUrl
}

extension ServiceError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .invalidResponse:
            return "invalid response"
        case .errorEmptyData:
            return "error empty data"
        case .invalidStatusCode:
            return "invalid status code"
        case .errorFromAPI(let error):
            return "request return an error: \(error)"
        case .decodingError:
            return "couldn't decode data"
        case .invalidUrl:
            return "malform URL"
        }
    }
}
