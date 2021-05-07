//
//  ExtensionUILabel.swift
//  LeBaluchon
//
//  Created by Manon Russo on 26/04/2021.
//

import UIKit

extension UILabel {
    func addCornerRadius() {
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 5
    }
}
