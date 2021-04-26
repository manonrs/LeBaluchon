//
//  ExtensionUIViewController.swift
//  LeBaluchon
//
//  Created by Manon Russo on 26/04/2021.
//

import Foundation
import UIKit

extension UIViewController {
    func showAlert() {
        let alertVC = UIAlertController(title: "Erreur", message: "Chargement des données impossible", preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alertVC, animated: true, completion: nil)
    }
}
