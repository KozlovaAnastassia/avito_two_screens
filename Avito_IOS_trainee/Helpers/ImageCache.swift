//
//  ImageCache.swift
//  Avito_IOS_trainee
//
//  Created by Анастасия on 31.08.2023.
//

import Foundation
import UIKit

class ImageCache {
        static let shared = ImageCache()

        private let cache = NSCache<NSString, UIImage>()
    
        func setImage(_ image: UIImage, forKey key: String) {
            cache.setObject(image, forKey: key as NSString)
        }
        func getImage(forKey key: String) -> UIImage? {
            return cache.object(forKey: key as NSString)
    }
}
