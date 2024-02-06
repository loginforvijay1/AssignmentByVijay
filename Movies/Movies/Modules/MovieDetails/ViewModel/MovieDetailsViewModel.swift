

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
    
    init(movieDetails: MovieDetailsData) {
        self.title = movieDetails.movieData.title
        self.subText = movieDetails.movieData.overview
        self.posterImage = movieDetails.moviePoster
        self.subTitle = DateFormatter.string(from: movieDetails.movieData.releaseDate, format: Constants.dateFormat)
    }
}
