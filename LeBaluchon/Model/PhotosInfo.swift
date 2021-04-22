//
//  PhotosInfo.swift
//  LeBaluchon
//
//  Created by Manon Russo on 15/04/2021.
//

import Foundation

struct PhotosInfo: Decodable {
    let urls: Urls
}

struct Urls: Decodable {
    let regular: String
}
