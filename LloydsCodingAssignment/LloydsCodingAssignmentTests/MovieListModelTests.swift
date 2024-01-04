//
//  MovieListModelTests.swift
//  LloydsCodingAssignmentTests
//
//  Created by Vemireddy Vijayasimha Reddy on 02/01/24.
//

import XCTest

class MovieListModelTests: XCTestCase {

    func testNowPlayingMovieResponseModel() {
        guard let movieList: MovieList = TestUtils().loadJson(filename: "moviedb_now_playing") else {
            XCTAssertThrowsError("unable to load file")
            return
        }
        XCTAssertEqual(movieList.movies?.count, 20)
        let movie = movieList.movies![0]
        XCTAssertEqual(movie.id, 848326)
        XCTAssertEqual(movie.title, "Rebel Moon - Part One: A Child of Fire")
        XCTAssertEqual(movie.posterPath, "/ui4DrH1cKk2vkHshcUcGt2lKxCm.jpg")
        XCTAssertEqual(movie.releaseDate, DateTransformer.transform("2023-12-15"))

    }
}
