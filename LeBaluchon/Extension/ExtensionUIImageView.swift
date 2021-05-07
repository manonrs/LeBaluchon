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
        DispatchQueue.global().async { [weak self] in
            guard let data = try? Data(contentsOf: url),
                  let image = UIImage(data: data) else { return }
            DispatchQueue.main.async  {
                self?.image = image
            }
        }
    }
    
    func loadCityImage(_ urls: String) {
        let urlString = "\(urls)"
        guard let url = URL(string: urlString) else { return }
        DispatchQueue.global().async { [weak self] in
            guard let data = try? Data(contentsOf: url),
                  let image = UIImage(data: data) else { return }
            DispatchQueue.main.async  {
                self?.image = image
            }
        }
    }
    
}
