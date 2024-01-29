

import Foundation
import XCTest
import PromiseKit

@testable import Movies

protocol MockMovieServiceType : MovieServiceType {
    var fetchPosterImageReturnValue: Data? {get set}
    var fetchNowPlayingMoviesGivenValue: MovieList? {get set}
}

class MockMovieService: MockMovieServiceType {

    var fetchNowPlayingMoviesCalled = false
    var fetchPosterImageCalled = false
    var fetchNowPlayingMoviesGivenValue: MovieList?
    var fetchPosterImageReturnValue: Data?

    func fetchNowPlayingMovies() -> Promise<MovieList> {
        fetchNowPlayingMoviesCalled = true
        guard let list = fetchNowPlayingMoviesGivenValue else {
            return brokenPromise()
        }

        return Promise.value(list)
    }

    func fetchPosterImage(path: String) -> Promise<Data> {
        fetchPosterImageCalled = true
        guard let data = fetchPosterImageReturnValue else {
            return brokenPromise()
        }

        return Promise.value(data)
    }
}
