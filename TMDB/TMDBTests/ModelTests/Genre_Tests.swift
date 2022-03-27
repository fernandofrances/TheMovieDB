//
//  Genre_Tests.swift
//  TMDBTests
//
//  Created by Fernando Frances  on 27/3/22.
//

import XCTest

class Genre_Tests: XCTestCase {

    var decoder: JSONDecoder!

    override func setUp() {
        super.setUp()
        decoder = JSONDecoder()
    }

    override func tearDown() {}

    func test_genre_decodeFromJSONWithSuccess() {
        guard let data = "Genre".readLocalJSONFile() else {
            XCTFail()
            return
        }
        XCTAssertNoThrow(try decoder.decode(Genre.self, from: data))
    }

    
    func test_genre_decodeFromJSONMissingRequiredValues() {
        guard let data = "GenreMissingRequiredValues".readLocalJSONFile() else {
            XCTFail()
            return
        }
        XCTAssertThrowsError(try decoder.decode(Genre.self, from: data))
    }


}
