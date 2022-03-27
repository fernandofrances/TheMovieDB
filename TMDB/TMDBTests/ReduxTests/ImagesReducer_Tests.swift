//
//  ImagesReducer_Tests.swift
//  TMDBTests
//
//  Created by Fernando Frances  on 27/3/22.
//

import XCTest

class ImagesReducer_Tests: XCTestCase {

    var state: AppState!

    override func setUp() {
        state = AppState.initial
    }

    override func tearDown() {}
    
    func test_imagesReducer_loadConfiguration_WithSuccess() {
        
        appReducer(state: &state, action: .images(action: .loadConfiguration))
        XCTAssertEqual(state.images.configuration.images.baseURL, Configuration.default.images.baseURL)
    }

    
    func test_imagesReducer_setConfiguration_withSuccess() {
        
        let urlString = "any"
        let url = URL(string: urlString)!
        
        appReducer(state: &state,
                   action: .images(action: .setConfiguration(Configuration(images: Configuration.Images(baseURL: url)))))
                   XCTAssertEqual(state.images.configuration.images.baseURL, url)
    }

}
