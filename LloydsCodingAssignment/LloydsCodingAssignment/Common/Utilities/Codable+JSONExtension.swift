//
//  Codable+JSONExtension.swift
//  LloydsCodingAssignment
//
//  Created by Vemireddy Vijayasimha Reddy on 02/01/24.
//

import Foundation

public extension Decodable {

    static var decoder: JSONDecoder { return JSONDecoder() }

    init?(jsonData: Data?) {
        guard let data = jsonData,
            let anInstance = try? Self.decoder.decode(Self.self, from: data)
            else { return nil }
        self = anInstance
    }

}
