//
//  ShowDetailReducer_Tests.swift
//  TMDBTests
//
//  Created by Fernando Frances  on 27/3/22.
//

import XCTest

class ShowDetailReducer_Tests: XCTestCase {

    var state: AppState!

    override func setUp() {
        state = AppState.initial
    }

    override func tearDown() {}
    
    func test_showDetailReducer_loadShowDetailAndRelated_WithSuccess() {
        
        let expectedState = AppState(topRated: TopRatedState(), showDetail: ShowDetailState(currentDetail: .progress), images: ImagesState())
        
        appReducer(state: &state, action: .showDetail(action: .loadShowDetailAndRelated(identifier: 1, page: 1)))
        XCTAssertEqual(state.showDetail.currentDetail, expectedState.showDetail.currentDetail)
    }

    func test_showDetailReducer_setShowDetailAndRelated_withSuccess() {
        
        let successLoadable = Loadable<[ShowDetail]>.success(nil)
        
        let expectedState = AppState(topRated: TopRatedState(), showDetail: ShowDetailState(currentDetail: successLoadable), images: ImagesState())
        appReducer(state: &state, action: .showDetail(action: .setDetail(successLoadable)))
        XCTAssertEqual(state.showDetail.currentDetail, expectedState.showDetail.currentDetail)
    }
    



}
