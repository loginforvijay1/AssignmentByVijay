

import Foundation
import PromiseKit
import UIKit

protocol MovieServiceType {
    func fetchNowPlayingMovies() -> Promise<MovieList>
    func fetchPosterImage(path: String) -> Promise<Data>
}

private let apiKey = "f7ae5a29253b3db883e101050692f0a8"

struct MovieServiceEndPoints {
    static let nowPlaying = "https://api.themoviedb.org/3/movie/now_playing"
    static let posterImage = "http://image.tmdb.org/t/p/w185"
}

struct MovieService: MovieServiceType {
    
    func fetchPosterImage(path: String) -> Promise<Data> {
        let urlString = MovieServiceEndPoints.posterImage.appending(path)
        guard let url =  URL(string: urlString) else {
            return brokenPromise()
        }
        
        return Promise<Data> { seal in
            URLSession.shared.dataTask(with: url) { (data, resp, err) in
                if let err = err {
                    seal.reject(err)
                    return
                } else if let data = data {
                    seal.fulfill(data)
                }
            }.resume()
        }
    }
    
    func fetchNowPlayingMovies() -> Promise<MovieList> {
        
        guard let url =  self.requestURL(from: MovieServiceEndPoints.nowPlaying) else {
            return brokenPromise()
        }
        return Promise<MovieList> { seal in
            URLSession.shared.dataTask(with: url) { (data, resp, err) in
                if let err = err {
                    seal.reject(err)
                    return
                } else if let data = data {
                    do {
                        let obj = try JSONDecoder().decode(MovieList.self, from: data)
                        seal.fulfill(obj)
                    } catch let error {
                        seal.reject(error)
                    }
                }
            }.resume()
        }
    }
}

private extension MovieService {
    
    func requestURL(from path: String) -> URL? {
        
        guard let url = URL(string: path),
              var components = URLComponents(url: url, resolvingAgainstBaseURL: false)   else {
            return nil
        }
        
        let apiKeyItem = URLQueryItem(name: "api_key", value: apiKey)
        components.queryItems = [apiKeyItem]
        return components.url
        
    }
}
