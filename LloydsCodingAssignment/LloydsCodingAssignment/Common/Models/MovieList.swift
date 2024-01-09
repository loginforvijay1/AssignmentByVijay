

import Foundation
struct MovieList: Codable {
    private(set) var movies: [Movie]?

    enum CodingKeys: String, CodingKey {
        case movies = "results"
    }
}
