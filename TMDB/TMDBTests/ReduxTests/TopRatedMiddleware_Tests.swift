//
//  TopRatedMiddleware_Tests.swift
//  TMDBTests
//
//  Created by Fernando Frances  on 27/3/22.
//

import XCTest
import Combine

class TopRatedMiddleware_Tests: XCTestCase {

    var store: AppStore!
    var cancelables: Set<AnyCancellable>!
    
    var topRatedService = TopRatedService(repository: MockTopRatedRepository())
    var topRatedServiceError = TopRatedService(repository: MockTopRatedRepositoryError())

    override func setUp() {
        cancelables = Set<AnyCancellable>()
    }

    override func tearDown() {
        cancelables.removeAll()
    }
    
    func test_topRatedMiddleware_loadTopRated_withSuccess() {
        store = AppStore(initial: AppState.initial, reducer: appReducer, middlewares: [topRatedMiddleware(service: topRatedService)])
        
        XCTAssertEqual(store.state.topRated.topRated, .initial)
        store.dispatch(.topRated(action: .loadTopRated(page: 1)))
        XCTAssertEqual(store.state.topRated.topRated, .progress)
        
        let promise = expectation(description: "Loading Top Rated shows")
        
        store.$state.sink { state in
            switch state.topRated.topRated {
            case .success(let value):
                if value != nil {
                    promise.fulfill()
                }
            default:
                break
            }
        }.store(in: &cancelables)
        
        wait(for: [promise], timeout: 0.5)
    }
    
    func test_topRatedMiddleware_loadTopRated_withError() {
        store = AppStore(initial: AppState.initial, reducer: appReducer, middlewares: [topRatedMiddleware(service: topRatedServiceError)])
        
        XCTAssertEqual(store.state.topRated.topRated, .initial)
        store.dispatch(.topRated(action: .loadTopRated(page: 1)))
        XCTAssertEqual(store.state.topRated.topRated, .progress)
        
        let promise = expectation(description: "Loading Top Rated with error")
        
        store.$state.sink { state in
            switch state.topRated.topRated {
            case .failure(_):
                promise.fulfill()
            default:
                break
            }
        }.store(in: &cancelables)
        
        wait(for: [promise], timeout: 0.5)
    }
    
}
