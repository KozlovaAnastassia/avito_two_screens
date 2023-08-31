//
//  Extension.swift
//  Avito_IOS_trainee
//
//  Created by Анастасия on 28.08.2023.
//

import Foundation
import UIKit

var imageCahce = NSCache<AnyObject, AnyObject>()
extension UIImageView {
    
    public  func imageFromServerURL(_ urlString: String) {
        if let image = imageCahce.object(forKey: urlString as NSString) as? UIImage {
            self.image = image
            return
        }
        guard let url = URL(string:  urlString) else {
            return
        }
        
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        imageCahce.setObject(image, forKey: urlString as NSString)
                        self?.image = image
                    }
                }
            }
        }
    }
}

class ImageHelper {
    private var images = NSCache<NSString, NSData>()
    let session: URLSession = URLSession.shared
    
    
    func download(imageURL: URL, completion: @escaping (Data?, Error?) -> (Void)) {
        if let imageData = images.object(forKey: imageURL.absoluteString as NSString) {
          print("using cached images")
          completion(imageData as Data, nil)
          return
        }
        
        let task = session.downloadTask(with: imageURL) { localUrl, response, error in
          if let error = error {
            completion(nil, error)
            return
          }
          
            guard let url = localUrl else { return }
            
          do {
            let data = try Data(contentsOf: url)
            self.images.setObject(data as NSData, forKey: imageURL.absoluteString as NSString)
            completion(data, nil)
          } catch let error {
            completion(nil, error)
          }
        }
        
        task.resume()
      }
}
