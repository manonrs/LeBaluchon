//
//  ExtensionUIImageView.swift
//  LeBaluchon
//
//  Created by Manon Russo on 12/04/2021.
//

import Foundation
import UIKit

extension UIImageView {
    
    func loadIcon(_ icon: String) {
        let urlString = "https://openweathermap.org/img/wn/\(icon)@2x.png"
        guard let url = URL(string: urlString) else { return }
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url)  {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async  {
                        self?.image = image
                    }
                }
            }
        }
    }
    
    func loadCityImage(_ urls: String) {
        let urlString = "\(urls)"
        guard let url = URL(string: urlString) else { return }
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url)  {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async  {
                        self?.image = image
                    }
                }
            }
        }
    }
    
//    func loadIcon(_ icon: String) {
//        let urlString = "https://openweathermap.org/img/wn/\(icon)@2x.png"
//        guard let url = URL(string: urlString) else { return }
//        URLSession.shared.dataTask(with: url) { [weak self] (data, _, _) in
//            guard let data = data else { return }
//            let image = UIImage(data: data)
//            DispatchQueue.main.async {
//                self?.image = image
//            }
//        }.resume()
//    }
//
//    func loadCityImage(_ urls: String) {
//        let urlString = "\(urls)"
//        guard let url = URL(string: urlString) else { return }
//        URLSession.shared.dataTask(with: url) { [weak self] (data, _, _) in
//            guard let data = data else { return }
//            let image = UIImage(data: data)
//            DispatchQueue.main.async {
//               self?.image = image
//            }
//        }.resume()
//    }

}
