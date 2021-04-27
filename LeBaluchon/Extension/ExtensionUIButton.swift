//
//  ExtensionUIButton.swift
//  LeBaluchon
//
//  Created by Manon Russo on 26/04/2021.
//

import Foundation
import UIKit

extension UIButton {
    func addShadow() {
        self.layer.shadowOffset = CGSize(width: 3, height: 3)
        self.layer.shadowOpacity = 1
        self.layer.shadowRadius = 2
        self.layer.shadowColor = UIColor.black.cgColor
    }
}
