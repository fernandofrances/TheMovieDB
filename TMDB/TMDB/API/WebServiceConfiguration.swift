//
//  WebServiceConfiguration.swift
//  TMDB
//
//  Created by Fernando Frances  on 26/3/22.
//

import Foundation

internal struct WebServiceConfiguration {
    
    let baseURL: String
    let language: String
    let apiKey: String

    private class Dummy {}

    static let `default` = WebServiceConfiguration(baseURL: Bundle(for: WebServiceConfiguration.Dummy.self)
                                                    .infoDictionary?["base_url"] as? String ?? "" ,
                                                   language: Bundle.main.preferredLocalizations[0],
                                                   apiKey: Bundle(for: WebServiceConfiguration.Dummy.self)
                                                    .infoDictionary?["api_key"] as? String ?? "")

    var parameters: [String: String] {
        return ["api_key": apiKey, "language": language]
    }
}
