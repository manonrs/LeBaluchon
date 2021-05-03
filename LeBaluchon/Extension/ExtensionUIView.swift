//
//  ExtensionUIView.swift
//  LeBaluchon
//
//  Created by Manon Russo on 03/05/2021.
//

import UIKit

extension UIView {
    func addShadow() {
        self.layer.shadowOffset = CGSize(width: 1, height: 1)
        self.layer.shadowOpacity = 0.8
        self.layer.shadowRadius = 2
        self.layer.shadowColor = UIColor.black.cgColor
    }
}
