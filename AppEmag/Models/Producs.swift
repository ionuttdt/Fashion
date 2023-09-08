//
//  Producs.swift
//  AppEmag
//
//  Created by Viorel on 06.09.2023.
//

import RealmSwift

struct Product: Codable {
    let id: Int
    let name: String
    let images: ProductImages
    let price: Double
    let originalPrice: Double
    let screenTitle: String
    let stockState: String // am vazut ca sunt doar "ok", voiam sa fac un enum, dar nu stiu caseurile
    
    init(entity: ProductEntity) {
        self.id = entity.product_id
        self.name = entity.product_name
        self.images = ProductImages(entity: entity.product_images)
        self.price = entity.product_price
        self.originalPrice = entity.product_original_price
        self.screenTitle = entity.product_screen_title
        self.stockState = entity.product_stock_state
    }
    
    enum CodingKeys: String, CodingKey {
        case id = "product_id"
        case name = "product_name"
        case images = "product_images"
        case price = "product_price"
        case originalPrice = "product_original_price"
        case screenTitle = "screen_title"
        case stockState = "product_stock_state"
    }
}

struct ProductImages: Codable {
    let listing: [String]
    let detail: [String]
    let zoom: [String]
    let thumb: [String]
    
    init(entity: ProductImagesEntity?) {
        self.listing = Array(entity?.listing ?? List<String>())
        self.detail = Array(entity?.detail ?? List<String>())
        self.zoom = Array(entity?.zoom ?? List<String>())
        self.thumb = Array(entity?.thumb ?? List<String>())
    }
}

struct Response: Codable {
    let products: [Product]
}
