//
//  ShowDetailMiddleware_Tests.swift
//  TMDBTests
//
//  Created by Fernando Frances  on 27/3/22.
//

import XCTest
import Combine

class ShowDetailMiddleware_Tests: XCTestCase {

    var store: AppStore!
    var cancelables: Set<AnyCancellable>!
    
    var showDetailService = ShowDetailService(repository: MockShowDetailRepository())
    var showDetailServiceError = ShowDetailService(repository: MockShowDetailRepositoryError())

    override func setUp() {
        cancelables = Set<AnyCancellable>()
    }

    override func tearDown() {
        cancelables.removeAll()
    }
    
    
    func test_showDetailMiddleware_loadShowDetailAndRelated_withSuccess() {
        
        store = AppStore(initial: AppState.initial, reducer: appReducer, middlewares: [showDetailMiddleware(service: showDetailService)])
        
        XCTAssertEqual(store.state.showDetail.currentDetail, .initial)
        store.dispatch(.showDetail(action: .loadShowDetailAndRelated(identifier: 1, page: 1)))
        XCTAssertEqual(store.state.showDetail.currentDetail, .progress)
        
        let promise = expectation(description: "Loading Similars")
        
        store.$state.sink { state in
            switch state.showDetail.currentDetail{
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
    
    func test_showDetailMiddleware_loadSimilars_withError() {
        
        store = AppStore(initial: AppState.initial, reducer: appReducer, middlewares: [showDetailMiddleware(service: showDetailServiceError)])
        
        XCTAssertEqual(store.state.showDetail.currentDetail, .initial)
        store.dispatch(.showDetail(action: .loadShowDetailAndRelated(identifier: 1, page: 1)))
        XCTAssertEqual(store.state.showDetail.currentDetail, .progress)
        
        let promise = expectation(description: "Loading Similars with error")
        
        store.$state.sink { state in
            switch state.showDetail.currentDetail{
            case .failure(_):
                promise.fulfill()
            default:
                break
            }
        }.store(in: &cancelables)
        
        wait(for: [promise], timeout: 0.5)
    }
}
