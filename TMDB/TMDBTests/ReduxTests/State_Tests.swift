//
//  State_Tests.swift
//  TMDBTests
//
//  Created by Fernando Frances  on 27/3/22.
//

import XCTest

class State_Tests: XCTestCase {
    override func setUp() {}
    
    override func tearDown() {}
    
    func test_state_init_setValuesCorrecltyOnInitialInit() {
        
        let state = AppState.initial
        XCTAssertEqual(state.topRated.topRated, .initial)
        XCTAssertNil(state.topRated.selectedShow)
        XCTAssertFalse(state.topRated.showSelected)
        XCTAssertEqual(state.showDetail.currentDetail, .initial)
        XCTAssertEqual(state.images.configuration.images.baseURL, Configuration.default.images.baseURL)
    }
    
    func test_state_init_setValuesCorrecltyOnAnyInit() {
        
        for _ in 0..<5 {
            
            let randomLoadableTopRated = Loadable<Page<Show>>.allCases.randomElement() ?? .initial
            let randomLoadableShowDetail = Loadable<[ShowDetail]>.allCases.randomElement() ?? .initial
            let imagesConfiguration = Configuration.default
            let showSelected = false
            let selectedShow: Show? = nil
            
           
            
            let newState = AppState(topRated: TopRatedState(topRated: randomLoadableTopRated,
                                                             showSelected: showSelected,
                                                             selectedShow: selectedShow),
                                    showDetail: ShowDetailState(currentDetail: randomLoadableShowDetail),
                                    images: ImagesState(configuration: imagesConfiguration))
            
            XCTAssertEqual(newState.topRated.topRated, randomLoadableTopRated)
            XCTAssertEqual(newState.showDetail.currentDetail, randomLoadableShowDetail)
            XCTAssertEqual(newState.topRated.selectedShow, selectedShow)
            XCTAssertEqual(newState.topRated.showSelected, showSelected)
            XCTAssertEqual(newState.images.configuration.images.baseURL, imagesConfiguration.images.baseURL)
        }
    }
}
