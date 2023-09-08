//
//  ProductEntity.swift
//  AppEmag
//
//  Created by Viorel on 07.09.2023.
//

import RealmSwift

class ProductEntity: Object, Decodable {
    @Persisted var product_id: Int = 0
    @Persisted var product_name: String = ""
    @Persisted var product_images: ProductImagesEntity?
    @Persisted var product_price: Double = 0.0
    @Persisted var product_original_price: Double = 0.0
    @Persisted var product_screen_title: String = ""
    @Persisted var product_stock_state: String = ""
    
    convenience init(product: Product) {
        self.init()
        
        self.product_id = product.id
        self.product_name = product.name
        self.product_images = ProductImagesEntity(product: product.images)
        self.product_price = product.price
        self.product_original_price = product.originalPrice
        self.product_screen_title = product.screenTitle
        self.product_stock_state = product.stockState
    }
}

class ProductImagesEntity: Object, Decodable {
    @Persisted var listing: List<String> = List<String>()
    @Persisted var detail: List<String> = List<String>()
    @Persisted var zoom: List<String> = List<String>()
    @Persisted var thumb: List<String> = List<String>()

    convenience init(product: ProductImages) {
        self.init()

        listing.append(objectsIn: product.listing)
        detail.append(objectsIn: product.detail)
        zoom.append(objectsIn: product.zoom)
        thumb.append(objectsIn: product.thumb)
    }
    
    static func convertToList(array: [String]) -> List<String> {
        let entityList = List<String>()
        array.forEach { value in
            entityList.append(value)
        }
        return entityList
    }
}

class ResponseEntity: Object, Decodable {
    @Persisted var products: List<ProductEntity>
}
