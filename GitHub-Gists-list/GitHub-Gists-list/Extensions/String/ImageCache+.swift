//
//  ImageCache+.swift
//  GitHub-Gists-list
//
//  Created by Руслан Парастаев on 27.09.2024.
//

import UIKit

extension String {
    
    // Function to fetch and cache the image based on the URL string
    public func setCachedImage(_ imageView: UIImageView) {
        // Check if the image is cached
        if let cachedImage = ImageCache.shared.image(forKey: self) {
            imageView.image = cachedImage // Use the cached image if available
        } else {
            // If not cached, download the image asynchronously
            if let url = URL(string: self) {
                URLSession.shared.dataTask(with: url) { [weak imageView] data, response, error in
                    // Ensure valid data and create an image
                    guard let data = data, let image = UIImage(data: data) else { return }
                    
                    // Cache the downloaded image
                    ImageCache.shared.setImage(image, forKey: self)
                    
                    // Update the UI on the main thread
                    DispatchQueue.main.async {
                        imageView?.image = image // Set the image once downloaded
                    }
                }.resume() // Start the URL session task
            }
        }
    }
    
}
