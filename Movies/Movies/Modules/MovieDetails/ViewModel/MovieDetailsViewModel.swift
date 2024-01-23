

import Foundation
import UIKit
import PromiseKit

protocol MovieDetailsViewModelType {
    var title: String { get }
    var subTitle: String { get }
    var subText: String { get }
    var posterImage: UIImage{ get }
}

struct MovieDetailsViewModel: MovieDetailsViewModelType {
    
    let title: String
    let subTitle: String
    let subText: String
    let posterImage: UIImage
    
    private let moviesService: MovieServiceType
    private let movie: Movie

    init( movie: Movie, posterImage: UIImage, moviesService: MovieServiceType) {
        self.moviesService = moviesService
        self.movie = movie
        subText = movie.overview
        title = movie.title
        subTitle = DateFormatter.string(from: movie.releaseDate, format: Constants.dateFormat)
        self.posterImage = posterImage
    }
}
