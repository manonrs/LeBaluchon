//
//  ExtensionUITextField.swift
//  LeBaluchon
//
//  Created by Manon Russo on 15/04/2021.
//

import UIKit
// mettre une seule méthode dans uitextinput
extension UITextField {
    func addDoneToolBar() {
        let toolbar: UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 44))
        toolbar.barStyle = .default
        toolbar.items = [

            UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil),
            UIBarButtonItem(title: "Valider", style: .plain, target: self.target, action: #selector(doneButtonTapped)),
            UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil),

        ]
        toolbar.sizeToFit()

        self.inputAccessoryView = toolbar
}
    // Default action:
    @objc func doneButtonTapped() { self.resignFirstResponder() }
}

extension UITextView {
    func addDoneCancelToolbar(onDone: (target: Any, action: Selector)? = nil, onCancel: (target: Any, action: Selector)? = nil) {
        let onCancel = onCancel ?? (target: self, action: #selector(cancelButtonTapped))
        let onDone = onDone ?? (target: self, action: #selector(doneButtonTapped))

        let toolbar: UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 44))
        toolbar.barStyle = .default
        toolbar.items = [
            UIBarButtonItem(title: "Annuler", style: .plain, target: onCancel.target, action: onCancel.action),
            UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil),
            UIBarButtonItem(title: "Valider", style: .done, target: onDone.target, action: onDone.action)
        ]
        toolbar.sizeToFit()

        self.inputAccessoryView = toolbar
    }
    
    func addCornerRadius() {
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 5
    }

    // Default actions:
    @objc func doneButtonTapped() { self.resignFirstResponder() }
    @objc func cancelButtonTapped() { self.resignFirstResponder() }
    
}
