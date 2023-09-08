//
//  ShopViewModel.swift
//  AppE
//
//  Created by Viorel on 06.09.2023.
//

import Combine
import Foundation

protocol ShopViewModelProtocol {
    func getClothings()
}

class ShopViewModel: ObservableObject, ShopViewModelProtocol {
    @Published var products: [Product] = []
    @Published var isGridMode: Bool = false
    @Published var error: ServerError?
    
    private var cancellable: AnyCancellable?
    
    func getClothings() {
        guard let url = URL(string: "https://m.fashiondays.com/mobile/9/g/women/clothing") else {
            return
        }
        
        var request = URLRequest(url: url)
        
        request.addValue("ro_RO", forHTTPHeaderField: "x-mobile-app-locale")
        
        if let productEntities = RealmManager.shared.getAllObjects(ProductEntity.self) {
            let oldProducts = productEntities.map{ Product(entity: $0) }
            self.products = oldProducts
        }
        
        let task = URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            if let data = data {
                if let decodedResponse = try? JSONDecoder().decode(Response.self, from: data) {
                    DispatchQueue.main.async {
                        RealmManager.shared.deleteAllObjects(ProductEntity.self)
                        RealmManager.shared.saveObjects(decodedResponse.products.map(ProductEntity.init(product:)))

                        self?.products = decodedResponse.products
                    }
                    
                    return
                } else if let decodedError = try? JSONDecoder().decode(ServerError.self, from: data) {
                    DispatchQueue.main.async {
                        self?.error = decodedError
                    }
                    return
                }
            }
        }
        
        task.resume()
    }
}
