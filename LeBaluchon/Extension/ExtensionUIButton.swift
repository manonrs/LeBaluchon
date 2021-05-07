//
//  ExtensionUIButton.swift
//  LeBaluchon
//
//  Created by Manon Russo on 26/04/2021.
//

import UIKit

extension UIButton {
    func addCornerRadius() {
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 5
    }
}
