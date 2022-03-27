//
//  TopRatedReducer_Tests.swift
//  TMDBTests
//
//  Created by Fernando Frances  on 27/3/22.
//

import XCTest

class TopRatedReducer_Tests: XCTestCase {

    var state: AppState!

    override func setUp() {
        state = AppState.initial
    }

    override func tearDown() {}
    
    func test_topRatedReducer_loadTopRated_WithSuccess() {
        
        let expectedState = AppState(topRated: TopRatedState(topRated: .progress),
                                     showDetail: ShowDetailState(),
                                     images: ImagesState())
        appReducer(state: &state, action: .topRated(action: .loadTopRated(page: 1)))
        XCTAssertEqual(state.topRated.topRated, expectedState.topRated.topRated)
    }

    
    func test_topRatedReducer_setTopRated_withSuccess() {
        
        let successLoadable = Loadable<Page<Show>>.success(nil)
        let expectedState = AppState(topRated: TopRatedState(topRated: successLoadable),
                                     showDetail: ShowDetailState(),
                                     images: ImagesState())
        appReducer(state: &state, action: .topRated(action: .setPage(successLoadable)))
        XCTAssertEqual(state.topRated.topRated, expectedState.topRated.topRated)
    }


}
