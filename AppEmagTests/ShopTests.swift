//
//  ShopTests.swift
//  AppEmagTests
//
//  Created by Viorel on 07.09.2023.
//

import XCTest

class ShopTests: XCTestCase {
    func testEndpointExists() {
        let endpointURL = URL(string: "https://m.fashiondays.com/mobile/9/g/women/clothing")!
        
        let expectation = XCTestExpectation(description: "Check if endpoint exists")
        
        var request = URLRequest(url: endpointURL)
        
        request.addValue("ro_RO", forHTTPHeaderField: "x-mobile-app-locale")
        
        let task = URLSession.shared.dataTask(with: request) { (_, response, error) in
            if let httpResponse = response as? HTTPURLResponse {
                if (200...299).contains(httpResponse.statusCode) {
                    expectation.fulfill()
                } else {
                    XCTFail("Endpoint returned status code: \(httpResponse.statusCode)")
                }
            } else if let error = error {
                XCTFail("Network request failed with error: \(error.localizedDescription)")
            } else {
                XCTFail("Unknown error")
            }
        }
        
        task.resume()
        
        wait(for: [expectation], timeout: 5.0)
    }
}
