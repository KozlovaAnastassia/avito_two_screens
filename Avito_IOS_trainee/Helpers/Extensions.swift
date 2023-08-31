//
//  Extension.swift
//  Avito_IOS_trainee
//
//  Created by Анастасия on 28.08.2023.
//

import Foundation
import UIKit

extension UIImageView {
    func loadImage(withURL urlString: String, placeholder: UIImage? = nil) {
        
        guard let url = URL(string:  urlString) else {return}
        self.image = placeholder
        let cacheKey = url.absoluteString
        
        if let cachedImage = ImageCache.shared.imageForKey(cacheKey) {
            self.image = cachedImage
            return
        }
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Ошибка загрузки изображения: \(error.localizedDescription)")
                return
            }
            
            guard let data = data, let image = UIImage(data: data) else {
                print("Не удалось создать изображениe")
                return
            }
            ImageCache.shared.setImage(image, forKey: cacheKey)
            DispatchQueue.main.async {
                self.image = image
            }
        }.resume()
    }
}
