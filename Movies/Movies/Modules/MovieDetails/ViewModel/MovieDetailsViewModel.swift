

import Foundation
import UIKit
import PromiseKit

struct MovieDetailsViewModel {
    
    let title: String
    let subTitle: String
    let subText: String
    let posterImage: UIImage
    init( movie: Movie, posterImage: UIImage) {
        subText = movie.overview
        title = movie.title
        self.posterImage = posterImage
        subTitle = DateFormatter.string(from: movie.releaseDate, format: Constants.dateFormat)
    }
}
