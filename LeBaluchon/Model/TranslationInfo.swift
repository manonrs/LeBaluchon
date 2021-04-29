//
//  TranslationInfo.swift
//  LeBaluchon
//
//  Created by Manon Russo on 16/04/2021.


import Foundation

struct TranslationInfo: Decodable {
    var data: DataTranslation
}

struct DataTranslation: Decodable {
    var translations: [Translations]
}

struct Translations: Decodable {
    let translatedText: String
}

