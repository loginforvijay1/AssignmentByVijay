

import Foundation
import PromiseKit
import UIKit

enum DownloadError: Error {
    case offline
    case generic

    var message: String {
        switch self {
        case .offline:
            return "Internet seems to be offline, please check the internet connection."
        default:
            return "Unable to load movies, please try again."
        }
    }
}

struct MovieViewItem {
    let movie: Movie
    let title: String
    let imageUrl: String
    let subTitle: String

    init(_ movie: Movie) {
        self.movie = movie
        title = movie.title
        imageUrl = movie.posterPath
        subTitle = DateFormatter.string(from: movie.releaseDate, format: Constants.dateFormat)
    }
}

protocol MovieListViewModelType {
    var title: String? { get }
    var cache:  NSCache<NSString, UIImage> { get }
    func loadMovies() -> Promise<[MovieViewItem]>
    func fetchImage(for item: MovieViewItem) -> Promise<UIImage>
}

struct MovieListViewModel: MovieListViewModelType {
    
    private let service: MovieServiceType
    let cache = NSCache<NSString, UIImage>()
    
    init(service: MovieServiceType) {
        self.service = service
    }
    
    var title: String? {
        return Constants.movieListTitile
    }
    
    func fetchImage(for item: MovieViewItem) -> Promise<UIImage> {
        if let image = cache.object(forKey: item.imageUrl as NSString) {
            return Promise.value(image)
        } else {
            return service.fetchPosterImage(path: item.imageUrl)
                .compactMap {
                    let posterImage =  UIImage(data: $0)
                    cache.setObject(posterImage ?? UIImage(), forKey: item.imageUrl as NSString)
                    return posterImage
                }
        }
    }
    
    func loadMovies() -> Promise<[MovieViewItem]> {
        return Promise { seal in
            service.fetchNowPlayingMovies()
                .done(on: DispatchQueue.main) { movieList in
                    let movieItems = movieList.movies?.compactMap( { MovieViewItem($0) })
                    seal.fulfill(movieItems ?? [])
                }
                .catch { error in
                    switch error {
                    case is URLError:
                        guard let code = (error as? URLError)?.code else { return }
                        if code == URLError.notConnectedToInternet {
                            seal.reject(DownloadError.offline)
                        } else {
                            seal.reject(DownloadError.generic)
                        }
                    default:
                        seal.reject(DownloadError.generic)
                    }
                }
        }
    }
}
