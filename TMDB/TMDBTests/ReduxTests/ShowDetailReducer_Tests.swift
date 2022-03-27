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
    
    func test_showDetailReducer_loadShowDetail_WithSuccess() {
        
        let expectedState = AppState(topRated: TopRatedState(), showDetail: ShowDetailState(currentDetail: .progress, currentSimilars: .initial), images: ImagesState())
        appReducer(state: &state, action: .showDetail(action: .loadDetail(identifier: 1)))
        XCTAssertEqual(state.showDetail.currentDetail, expectedState.showDetail.currentDetail)
    }

    func test_showDetailReducer_setShowDetail_withSuccess() {
        
        let successLoadable = Loadable<ShowDetail>.success(nil)
        
        let expectedState = AppState(topRated: TopRatedState(), showDetail: ShowDetailState(currentDetail: successLoadable, currentSimilars: .initial), images: ImagesState())
        appReducer(state: &state, action: .showDetail(action: .setDetail(successLoadable)))
        XCTAssertEqual(state.showDetail.currentDetail, expectedState.showDetail.currentDetail)
    }
    
    func test_showDetailReducer_loadSimilars_WithSuccess() {
        
        let expectedState = AppState(topRated: TopRatedState(), showDetail: ShowDetailState(currentDetail: .initial, currentSimilars: .progress), images: ImagesState())
        appReducer(state: &state, action: .showDetail(action: .loadSimilars(identifier: 1, page: 1)))
        XCTAssertEqual(state.showDetail.currentSimilars, expectedState.showDetail.currentSimilars)
    }
    
    func test_showDetailReducer_setSimilars_withSuccess() {
        
        let successLoadable = Loadable<Page<Show>>.success(nil)
        
        let expectedState = AppState(topRated: TopRatedState(), showDetail: ShowDetailState(currentDetail: .initial, currentSimilars: successLoadable), images: ImagesState())
        appReducer(state: &state, action: .showDetail(action: .setSimilars(successLoadable)))
        XCTAssertEqual(state.showDetail.currentSimilars, expectedState.showDetail.currentSimilars)
    }



}
