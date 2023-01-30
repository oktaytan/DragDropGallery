//
//  UIImageView+Ext.swift
//  DragDropGallery
//
//  Created by Oktay Tanrıkulu on 29.01.2023.
//

import UIKit

let imageCache = NSCache<NSString, UIImage>()

extension UIImageView {
    
    @discardableResult
    func loadImageFromUrl(urlString: String,
                          placeholder: UIImage? = nil) -> URLSessionDataTask? {
        
        self.image = nil
        
        let key = NSString(string: urlString)
        
        if let cachedImage = imageCache.object(forKey: key) {
            self.image = cachedImage
            return nil
        }
        
        guard let url = URL(string: urlString) else {
            return nil
        }
        
        if let placeholder = placeholder {
            self.image = placeholder
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, _, _ in
            DispatchQueue.main.async {
                if let data = data,
                    let downloadImage = UIImage(data: data) {
                    imageCache.setObject(downloadImage, forKey: key)
                    self.image = downloadImage
                }
            }
        }
        
        task.resume()
        
        return task
    }
}
