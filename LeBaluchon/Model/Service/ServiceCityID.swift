//
//  ServiceCityID.swift
//  LeBaluchon
//
//  Created by Manon Russo on 28/04/2021.
//let lyonAlbumId = "21328203"
//let nyAlbumId = "3541178"

import Foundation
//import UIKit

enum Album: String {
    case lyon
    case newYork
}

extension Album {
    var cityID: String? {
        switch self {
        case .lyon :
            return "21328203" /*"426804"*/
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
            return "3541178"
        }
    }
}
