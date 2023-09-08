//
//  GridItemView.swift
//  AppEmag
//
//  Created by Viorel on 06.09.2023.
//

import SwiftUI

struct GridItemView: View {
    let product: Product
    let itemsPerRow: Int
    
    @State private var image: Image?

    var body: some View {
        VStack {
            if let image = image {
                imageStack(image)
            } else {
                loading
            }
        }
        .frame(width: calculateItemWidth(itemsPerRow: itemsPerRow))
        .cornerRadius(10)
    }
    
    func imageStack(_ image: Image) -> some View {
        VStack {
            image
                .resizable()
                .aspectRatio(contentMode: .fit)
            
            VStack(alignment: .center) {
                Text("PRP: " + String(product.originalPrice))
                    .font(.system(size: 10))
                    .foregroundColor(.gray)
                
                Text(String(product.price) + "Lei")
                    .font(.system(size: 14))
                    .fontWeight(.medium)
                    .foregroundColor(.black)
            }
            .padding(.horizontal, 4)
        }
    }
    
    var loading: some View {
        ProgressView()
            .onAppear {
                fetchImage()
            }
    }

    private func fetchImage() {
        guard let urlString = product.images.listing.first,
              let url = URL(string: urlString) else {
            return
        }

        URLSession.shared.dataTask(with: url) { data, _, error in
            if let data = data, let uiImage = UIImage(data: data) {
                let image = Image(uiImage: uiImage)

                DispatchQueue.main.async {
                    self.image = image
                }
            }
        }.resume()
    }
    
    private func calculateItemWidth(itemsPerRow: Int) -> CGFloat {
        let screenWidth = UIScreen.main.bounds.width - 24 * 2
        let spacing: CGFloat = 16.0
        let availableWidth = (screenWidth - (CGFloat(itemsPerRow + 1) * spacing)) / (itemsPerRow == 2 ? 1.0 : 1.5)
        return availableWidth / CGFloat(itemsPerRow)
    }
}
