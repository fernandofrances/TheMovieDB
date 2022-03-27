//
//  ImagesMiddleware_Tests.swift
//  TMDBTests
//
//  Created by Fernando Frances  on 27/3/22.
//

import XCTest
import Combine

class ImagesMiddleware_Tests: XCTestCase {

    var store: AppStore!
    var cancelables: Set<AnyCancellable>!
    
    var imagesService = ImagesService(repository: MockImagesRepository())
    var imagesServiceError = ImagesService(repository: MockImagesRepositoryError())

    override func setUp() {
        cancelables = Set<AnyCancellable>()
    }

    override func tearDown() {
        cancelables.removeAll()
    }
    
    func test_imagesMiddleware_loadConfiguration_withSuccess() {
        store = AppStore(initial: AppState.initial, reducer: appReducer, middlewares: [imagesMiddleware(service: imagesService)])
        
        let configuration = Configuration.default
        
        XCTAssertEqual(store.state.images.configuration.images.baseURL, configuration.images.baseURL)
        store.dispatch(.images(action: .loadConfiguration))
        XCTAssertEqual(store.state.images.configuration.images.baseURL, configuration.images.baseURL)
        
        let promise = expectation(description: "Loading Configuration with success")
        
        store.$state.sink { state in
            if state.images.configuration.images.baseURL == MockImagesRepository.mockBaseURL {
                promise.fulfill()
            }
        }.store(in: &cancelables)
        
        wait(for: [promise], timeout: 0.5)
    }
    
    func test_imagesMiddleware_loadConfiguration_withError() {
        store = AppStore(initial: AppState.initial, reducer: appReducer, middlewares: [imagesMiddleware(service: imagesServiceError)])
        
        let configuration = Configuration.default
        
        XCTAssertEqual(store.state.images.configuration.images.baseURL, configuration.images.baseURL)
        store.dispatch(.images(action: .loadConfiguration))
        XCTAssertEqual(store.state.images.configuration.images.baseURL, configuration.images.baseURL)
        
        let promise = expectation(description: "Loading Configuration with error")
        
        // If request fails, it returns default config URL
        
        store.$state
            .dropFirst()
            .sink(receiveValue: { state in
                if state.images.configuration.images.baseURL == configuration.images.baseURL {
                    promise.fulfill()
                }
            })
            .store(in: &cancelables)
        
        wait(for: [promise], timeout: 0.5)
    }
}
