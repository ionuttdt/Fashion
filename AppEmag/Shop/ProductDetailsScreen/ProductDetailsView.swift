//
//  ProductDetailsView.swift
//  AppE
//
//  Created by Viorel on 06.09.2023.
//

import SwiftUI

struct ProductDetailsView: View {
    @ObservedObject var model: ProductDetailsViewModel
    
    init(_ product: Product) {
        _model = ObservedObject(wrappedValue: ProductDetailsViewModel(product: product))
        
        UILabel.appearance(whenContainedInInstancesOf: [UINavigationBar.self]).adjustsFontSizeToFitWidth = true
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 12) {
                images
                
                texts
                
                status
            }
        }
        .padding(.horizontal)
        .navigationBarTitleDisplayMode(.automatic)
        .navigationBarTitle(model.product.name)
        .onAppear {
            model.fetchImages()
        }
    }
    
    var images: some View {
        TabView {
            ForEach(model.images, id: \.self) { image in
                image.image
                    .resizable()
                    .scaledToFit()
            }
        }
        .frame(height: 300)
        .tabViewStyle(PageTabViewStyle())
    }
    
    var texts: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(model.product.name)
                .font(.title)
            
            Text("PRP: \(model.product.price)")
                .font(.body)
                .foregroundColor(.gray)
            
            Text("Pret: \(model.product.price)")
                .font(.headline)
        }
    }
    
    @ViewBuilder
    var status: some View {
        if model.product.stockState == "ok" {
            Text("Produs disponibil")
                .foregroundColor(.green)
        } else {
            Text("Produs indisponibil")
                .foregroundColor(.red)
        }
    }
}
