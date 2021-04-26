//
//  ExtensionUIImageView.swift
//  LeBaluchon
//
//  Created by Manon Russo on 12/04/2021.
//

import UIKit

extension UIImageView {
    func loadIcon(_ icon: String) {
        
        let urlString = "https://openweathermap.org/img/wn/\(icon)@2x.png"
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            guard data != nil else { return }
            
            let image = UIImage(data: data!)
            DispatchQueue.main.async { [self] in
                self.image = image
//                image?.withTintColor(.label)
            }
        }.resume()
    }
    
    func loadCityImage(_ urls: String) {
        let urlString = "\(urls)"
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            guard data != nil else { return }
            
            let image = UIImage(data: data!)
            DispatchQueue.main.async { [self] in
                self.image = image
            }
        }.resume()
        
    }
    func adShadow() {
        self.layer.shadowOffset = CGSize(width: 1, height: 1)
        self.layer.shadowOpacity = 0.8
        self.layer.shadowRadius = 2
        self.layer.shadowColor = UIColor.black.cgColor
    }
    
}
