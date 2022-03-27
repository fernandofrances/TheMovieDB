//
//  Show_Tests.swift
//  TMDBTests
//
//  Created by Fernando Frances  on 27/3/22.
//

import XCTest
@testable import TMDB

class Show_Tests: XCTestCase {
    var decoder: JSONDecoder!

    override func setUp() {
        super.setUp()
        decoder = JSONDecoder()
    }

    override func tearDown() {}

    func test_show_decodeFromJSONWithSuccess() {
        guard let data = "Show".readLocalJSONFile() else {
            XCTFail()
            return
        }
        XCTAssertNoThrow(try decoder.decode(Show.self, from: data))
    }
    
    func test_show_decodeFromJSONWithMissingOptionalValues() {
        guard let data = "ShowMissingOptionalValues".readLocalJSONFile() else {
            XCTFail()
            return
        }
        XCTAssertNoThrow(try decoder.decode(Show.self, from: data))
    }
    
    func test_show_decodeFromJSONMissingRequiredValues() {
        guard let data = "ShowMissingRequiredValues".readLocalJSONFile() else {
            XCTFail()
            return
        }
        XCTAssertThrowsError(try decoder.decode(Show.self, from: data))
    }

}
