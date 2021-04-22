//
//  RateInfo.swift
//  LeBaluchon
//
//  Created by Manon Russo on 13/04/2021.
//

import Foundation
struct RateInfo: Decodable {
//    var rates: Rates
    let rates: Rates
    let base: String
    let success: Bool
    
//    var euroAmount: Float?
//    var euroToDollar: Float? {
//        let rate = rates.USD ?? 0.0
//        let amount = euroAmount ?? 0.0
//        return rate * amount
//    }
}

struct Rates: Decodable {
    let USD: Float?
}
