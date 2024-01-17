

import Foundation
import UIKit
import PromiseKit

protocol MovieDetailsViewModelType {
    var title: String { get }
    var subTitle: String { get }
    var subText: String { get }

    func fetchMovieImage() -> Promise<UIImage>
}

struct MovieDetailsViewModel: MovieDetailsViewModelType {

    let title: String
    let subTitle: String
    let subText: String

    private let moviesService: MovieServiceType
    private let movie: Movie

    init( movie: Movie, moviesService: MovieServiceType) {
        self.moviesService = moviesService
        self.movie = movie
        subText = movie.overview
        title = movie.title
        subTitle = DateFormatter.string(from: movie.releaseDate, format: Constants.dateFormat)
    }

    func fetchMovieImage() -> Promise<UIImage> {
        return moviesService.fetchPosterImage(path: movie.posterPath)
            .compactMap { UIImage(data: $0) }
    }
}
