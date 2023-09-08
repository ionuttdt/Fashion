//
//  ProductDetailsViewModel.swift
//  AppE
//
//  Created by Viorel on 06.09.2023.
//

import Combine
import Foundation
import SwiftUI

protocol ProductDetailsViewModelProtocol {
    func fetchImages()
}

class ProductDetailsViewModel: ObservableObject, ProductDetailsViewModelProtocol {
    let product: Product
    @Published var images: [HashableImage] = []
    
    var imageURLs: [URL] {
        var urls: [URL] = []
        var urlStrings = product.images.detail
        urlStrings.append(contentsOf: product.images.zoom)
        urlStrings.append(contentsOf: product.images.listing)
        
        for imageURL in urlStrings {
            if let url = URL(string: imageURL) {
                urls.append(url)
            }
        }

        return urls
    }
    
    init(product: Product) {
        self.product = product
    }
    
    func fetchImages() {
        for imageURL in imageURLs {
            URLSession.shared.dataTask(with: imageURL) { data, _, error in
                if let data = data, let uiImage = UIImage(data: data) {
                    let image = Image(uiImage: uiImage)

                    DispatchQueue.main.async {
                        self.images.append(HashableImage(image))
                    }
                }
            }.resume()
        }
    }
}
