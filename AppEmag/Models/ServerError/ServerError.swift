//
//  ServerError.swift
//  AppEmag
//
//  Created by Viorel on 06.09.2023.
//

import Foundation

struct ServerError: Codable {
    let errorCode: String
    let errorMessage: String

    enum CodingKeys: String, CodingKey {
        case errorCode = "error_code"
        case errorMessage = "error_message"
    }
}
