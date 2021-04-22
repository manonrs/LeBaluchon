//
//  ExtensionFloat.swift
//  LeBaluchon
//
//  Created by Manon Russo on 13/04/2021.
//

import Foundation

extension Float {
   /// This methods is called in displayResult(), delete decimal for integer number.
    // nom + générique
    func editMaxDigitTo(_ numberOfDigit: Int) -> String {
       let formatter = NumberFormatter()
       let number = NSNumber(value: self)
       formatter.minimumFractionDigits = 0
    // passer en paramètre
       formatter.maximumFractionDigits = numberOfDigit
       return String(formatter.string(from: number) ?? "\(self)")
   }
}
