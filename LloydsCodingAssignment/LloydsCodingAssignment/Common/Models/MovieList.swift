//
//  MoviesList.swift
//  LloydsCodingAssignment
//
//  Created by Vemireddy Vijayasimha Reddy on 02/01/24.
//

import Foundation
struct MovieList: Codable {
    private(set) var movies: [Movie]?

    enum CodingKeys: String, CodingKey {
        case movies = "results"
    }
}
