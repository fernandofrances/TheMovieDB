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
        XCTAssertEqual(state.showDetail.currentDetail, .initial)
        XCTAssertEqual(state.showDetail.currentSimilars, .initial)
        XCTAssertEqual(state.images.configuration.images.baseURL, Configuration.default.images.baseURL)
    }
    
    func test_state_init_setValuesCorrecltyOnAnyInit() {
        
        for _ in 0..<5 {
            
            let randomLoadableTopRated = Loadable<Page<Show>>.allCases.randomElement() ?? .initial
            let randomLoadableShowDetail = Loadable<ShowDetail>.allCases.randomElement() ?? .initial
            let randomLoadableSimilars = Loadable<Page<Show>>.allCases.randomElement() ?? .initial
            let imagesConfiguration = Configuration.default
            
            
            let newState = AppState(topRated: TopRatedState(topRated: randomLoadableTopRated),
                                    showDetail: ShowDetailState(currentDetail: randomLoadableShowDetail,
                                                                currentSimilars: randomLoadableSimilars),
                                    images: ImagesState(configuration: imagesConfiguration))
            
            XCTAssertEqual(newState.topRated.topRated, randomLoadableTopRated)
            XCTAssertEqual(newState.showDetail.currentDetail, randomLoadableShowDetail)
            XCTAssertEqual(newState.showDetail.currentSimilars, randomLoadableSimilars)
            XCTAssertEqual(newState.images.configuration.images.baseURL, imagesConfiguration.images.baseURL)
        }
    }
}
