

import Foundation
import UIKit
import PromiseKit

protocol MovieDetailsViewModelType {
    var title: String { get }
    var subTitle: String { get }
    var subText: String { get }
    var posterImage: UIImage { get }
}

struct MovieDetailsViewModel: MovieDetailsViewModelType {
    
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
