//
//  ShowDetail_Tests.swift
//  TMDBTests
//
//  Created by Fernando Frances  on 27/3/22.
//

import XCTest

class ShowDetail_Tests: XCTestCase {

    var decoder: JSONDecoder!

    override func setUp() {
        super.setUp()
        decoder = JSONDecoder()
    }

    override func tearDown() {}

    func test_showDetail_decodeFromJSONWithSuccess() {
        guard let data = "ShowDetail".readLocalJSONFile() else {
            XCTFail()
            return
        }
        XCTAssertNoThrow(try decoder.decode(ShowDetail.self, from: data))
    }
    
    func test_showDetail_decodeFromJSONWithMissingOptionalValues() {
        guard let data = "ShowDetailMissingOptionalValues".readLocalJSONFile() else {
            XCTFail()
            return
        }
        XCTAssertNoThrow(try decoder.decode(ShowDetail.self, from: data))
    }
    
    func test_showDetail_decodeFromJSONMissingRequiredValues() {
        guard let data = "ShowDetailMissingRequiredValues".readLocalJSONFile() else {
            XCTFail()
            return
        }
        XCTAssertThrowsError(try decoder.decode(ShowDetail.self, from: data))
    }

}
