//
//  HashableImage.swift
//  AppEmag
//
//  Created by Viorel on 07.09.2023.
//

import SwiftUI

struct HashableImage: Hashable {
    private let id = UUID()
    let image: Image

    init(_ image: Image) {
        self.image = image
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    static func ==(lhs: HashableImage, rhs: HashableImage) -> Bool {
        return lhs.id == rhs.id
    }
}
