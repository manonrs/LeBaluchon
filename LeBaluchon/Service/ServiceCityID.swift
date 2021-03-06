//
//  ServiceCityID.swift
//  LeBaluchon
//
//  Created by Manon Russo on 28/04/2021.

import Foundation

enum Album: String {
    case lyon
    case newYork
}

extension Album {
    var cityID: String {
        switch self {
        case .lyon :
            return "21328203" /*or "426804"*/
        case .newYork :
            return "3541178"
        }
    }
}

enum WeatherId: String {
    case lyon
    case newYork
}

extension WeatherId {
    var cityID: String {
        switch self {
        case .lyon :
           return "2996944"
        case .newYork :
            return "5128581"
        }
    }
}
