//
//  ExtensionString.swift
//  LeBaluchon
//
//  Created by Manon Russo on 16/04/2021.
//

import Foundation

extension String {
    func capitalizingFirstLetter() -> String {
            return prefix(1).capitalized + dropFirst()
        /// Example : translating "Bonjour" to "Hello"
        /// prefix(1).capitalized is "H", dropFirst() is "ello"
        }
    
}
