//
//  ImageCache.swift
//  GitHub-Gists-list
//
//  Created by Руслан Парастаев on 27.09.2024.
//

import UIKit

final class ImageCache {
    
    // MARK: - Singleton Instance
    // Shared instance of ImageCache for global access
    static let shared = ImageCache()
    
    // MARK: - NSCache Setup
    // NSCache object for caching images with NSString keys
    private static let cache = NSCache<NSString, UIImage>()
    
    // MARK: - Init
    // Private initializer to prevent instantiation from outside the class (Singleton Pattern)
    private init() {}
    
    // MARK: - Image Retrieval
    // image(forKey:): Retrieves an image from the cache using the given key
    func image(forKey key: String) -> UIImage? {
        return ImageCache.cache.object(forKey: key as NSString) // Returns cached image if found
    }
    
    // MARK: - Store Image
    // setImage(_:forKey:): Stores an image in the cache with the associated key
    func setImage(_ image: UIImage, forKey key: String) {
        ImageCache.cache.setObject(image, forKey: key as NSString) // Caches the image with a key
    }
    
}


