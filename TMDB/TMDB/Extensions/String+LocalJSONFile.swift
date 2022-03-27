//
//  String+LocalJSONFile.swift
//  TMDB
//
//  Created by Fernando Frances  on 27/3/22.
//

import Foundation

extension String {
    func readLocalJSONFile() -> Data? {
        do {
            if let filePath = Bundle.main.path(forResource: self, ofType: "json") {
                let fileUrl = URL(fileURLWithPath: filePath)
                let data = try Data(contentsOf: fileUrl)
                return data
            }
        } catch {
            print("Error reading file with name \(self)")
        }
        return nil
    }
}

