//
//  Page_Tests.swift
//  TMDBTests
//
//  Created by Fernando Frances  on 27/3/22.
//

import XCTest

class Page_Tests: XCTestCase {

    var decoder: JSONDecoder!

    override func setUp() {
        super.setUp()
        decoder = JSONDecoder()
    }

    override func tearDown() {}

    func test_page_decodeFromJSONWithSuccess() {
        guard let data = "Page".readLocalJSONFile() else {
            XCTFail()
            return
        }
        XCTAssertNoThrow(try decoder.decode(Page<Show>.self, from: data))
    }

    
    func test_page_decodeFromJSONMissingRequiredValues() {
        guard let data = "PageMissingRequiredValues".readLocalJSONFile() else {
            XCTFail()
            return
        }
        XCTAssertThrowsError(try decoder.decode(Page<Show>.self, from: data))
    }

}
