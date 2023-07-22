//
//  CacheAsyncImage.swift
//  Rick&Morty app
//
//  Created by Eduardo Herrera on 17/7/23.
//


import SwiftUI

struct CacheAsyncImage: View {
    private let url: URL
    @State private var image: UIImage?
    
    init(url: URL) {
        self.url = url
    }
    
    var body: some View {
        if let image = image {
            Image(uiImage: image)
                .resizable()
                .aspectRatio(contentMode: .fill)
              
        } else {
            Color.gray // Placeholder image or loading indicator
                .onAppear(perform: loadImage)
        }
    }
    
    private func loadImage() {
        let urlRequest = URLRequest(url: url)
        
        // Check if the image is already in cache
        if let cachedResponse = URLCache.shared.cachedResponse(for: urlRequest),
           let image = UIImage(data: cachedResponse.data) {
            self.image = image
            return
        }
        
        // Fetch the image from the network
        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            guard let data = data,
                  let response = response,
                  let image = UIImage(data: data) else {
                return
            }
            
            // Cache the image response
            let cachedResponse = CachedURLResponse(response: response, data: data)
            URLCache.shared.storeCachedResponse(cachedResponse, for: urlRequest)
            
            DispatchQueue.main.async {
                self.image = image
            }
        }.resume()
    }
}


