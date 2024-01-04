//
//  TestUtils.swift
//  LloydsCodingAssignmentTests
//
//  Created by Vemireddy Vijayasimha Reddy on 02/01/24.
//

import Foundation
class TestUtils {
    
    func loadJson<T: Decodable>(filename fileName: String) -> T? {
        let testBundle = Bundle(for: type(of: self))
        guard let url = testBundle.url(forResource: fileName, withExtension: "json") else {
            return nil
        }
        
        guard let data = try? Data(contentsOf: url) else {
            return nil
        }
        
        return T(jsonData: data)
    }

    func loadImageData(filename fileName: String) -> Data? {
        let testBundle = Bundle(for: type(of: self))
        guard let url = testBundle.url(forResource: fileName, withExtension: "png") else {
            return nil
        }

        return try? Data(contentsOf: url)
    }
}
