//
//  Endpoint_Tests.swift
//  TMDBTests
//
//  Created by Fernando Frances  on 27/3/22.
//

import XCTest
@testable import TMDB

class Endpoint_Tests: XCTestCase {
    
    private var configuration: WebServiceConfiguration?
    
    override func setUp() {
        super.setUp()
        configuration = WebServiceConfiguration(baseURL: Bundle.main.infoDictionary?["base_url"] as? String ?? "",
                                                language: Bundle.main.preferredLocalizations[0],
                                                apiKey:  Bundle.main.infoDictionary?["api_key"] as? String ?? "")
    }
    
    override func tearDownWithError() throws {}
    
    func test_endpoint_request_throwsError() {
        
        guard let configuration = self.configuration else {
            XCTFail()
            return
        }
        
        let endpointValue = Endpoint.allCases.randomElement() ?? .show(identifier: Int64.random(in: 0..<100))
        XCTAssertThrowsError(try endpointValue.request(with: "##<>Invalid#String<>", adding: configuration.parameters))
        
    }
    
    func test_endpoint_request_returnsValidRequest() {
        
        guard let configuration = self.configuration else {
            XCTFail()
            return
        }
        
        for _ in 0..<5 { // try for different random enum cases
            
            let endpointValue = Endpoint.allCases.randomElement() ?? .show(identifier: Int64.random(in: 0..<100))
            
            var parameters: [String: String] = [:]
            endpointValue.parameters.forEach { parameters.updateValue($1, forKey: $0)}
            configuration.parameters.forEach { parameters.updateValue($1, forKey: $0)}
            
            do {
                
                let request = try endpointValue.request(with: configuration.baseURL, adding: configuration.parameters)
                guard let url = request.url else { throw APIError.invalidURL }
                var queryItemsFromRequest: [String: String] = [:]
                url.query?.components(separatedBy: "&")
                    .forEach { queryItem in
                        let valueKey = queryItem.components(separatedBy: "=")
                        queryItemsFromRequest.updateValue(valueKey.last!, forKey: valueKey.first!)
                    }
                
                let pathFrom = configuration.baseURL.components(separatedBy: "/").last
                let path = url.path.components(separatedBy: pathFrom ?? "").last ?? ""
                let baseURL = (url.absoluteString.components(separatedBy: path).first ?? "")
                
                XCTAssertEqual(configuration.baseURL, baseURL)
                XCTAssertEqual(endpointValue.path, path)
                
                queryItemsFromRequest.forEach { key, value in
                    XCTAssertNotNil(parameters[key])
                    XCTAssertEqual(parameters[key], value)
                }
                
            } catch {
                XCTFail()
            }
        }
        
    }
}
