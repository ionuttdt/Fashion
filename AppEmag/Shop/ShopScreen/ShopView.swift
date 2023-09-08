//
//  ShopView.swift
//  AppE
//
//  Created by Viorel on 06.09.2023.
//

import SwiftUI
import Combine

struct ShopView: View {
    @ObservedObject var model: ShopViewModel
    
    init() {
        _model = ObservedObject(wrappedValue: ShopViewModel())
    }

    var body: some View {
        VStack {
            if let error = model.error {
                Text("Error: \(error.errorMessage)")
                    .foregroundColor(.red)
                    .fontWeight(.bold)
            }
            
            ScrollView {
                LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 16), count: model.isGridMode ? 2 : 1), spacing: 16) {
                    ForEach(model.products, id: \.id) { product in
                        NavigationLink(destination: ProductDetailsView(product)) {
                            GridItemView(product: product, itemsPerRow: model.isGridMode ? 2 : 1)
                        }
                    }
                }
                .padding()
            }
        }
        .padding(.horizontal, 24)
        .toolbar {
            Button(action: {
                model.isGridMode.toggle()
            }) {
                if model.isGridMode {
                    Image("stack")
                        .resizable()
                        .frame(width: 12, height: 24)
                        .padding(.horizontal, 6)
                } else {
                    Image("grid")
                        .resizable()
                        .frame(width: 24, height: 24)
                }
            }
        }
        .onAppear {
            model.getClothings()
        }
    }
}

struct ShopView_Previews: PreviewProvider {
    static var previews: some View {
        ShopView()
    }
}
