//
//  ExtensionUILabel.swift
//  LeBaluchon
//
//  Created by Manon Russo on 26/04/2021.
//

import Foundation

import UIKit

extension UILabel {
    func addShadow() {
        self.layer.shadowOffset = CGSize(width: 1, height: 1)
        self.layer.shadowOpacity = 0.8
        self.layer.shadowRadius = 2
        self.layer.shadowColor = UIColor.black.cgColor
    }
    func addCornerRadius() {
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 5
    }
    
}
