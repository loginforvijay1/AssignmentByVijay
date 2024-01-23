

import Foundation
import UIKit
import PromiseKit

struct MovieDetailsViewModel {
    
    internal let title: String
    internal let subTitle: String
    internal let subText: String
    internal let posterImage: UIImage
    init( movie: Movie, posterImage: UIImage) {
        subText = movie.overview
        title = movie.title
        self.posterImage = posterImage
        subTitle = DateFormatter.string(from: movie.releaseDate, format: Constants.dateFormat)
    }
}
