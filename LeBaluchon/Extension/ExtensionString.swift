//
//  ExtensionString.swift
//  LeBaluchon
//
//  Created by Manon Russo on 16/04/2021.
//

import Foundation

extension String {
    func replace(target: String, withString: String) -> String {
        return self.replacingOccurrences(of: target, with: withString)
    }
    
    func capitalizingFirstLetter() -> String {
            return prefix(1).capitalized + dropFirst()
        }

//        mutating func capitalizeFirstLetter() {
//            self = self.capitalizingFirstLetter()
//        }
    
}
