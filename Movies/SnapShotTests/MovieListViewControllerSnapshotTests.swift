//
//  MovieListViewControllerSnapshotTest.swift
//  MoviesTests
//
//  Created by Vemireddy Vijayasimha Reddy on 29/01/24.
//

import XCTest
import SnapshotTesting
@testable import Movies

final class MovieListViewControllerSnapshotTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Set the isRecording  to true initially to generate reference snapshots
        // isRecording = true
        isRecording = false
    }
    func testMovieListViewController(){
        let movieListViewController = MovieListViewController()
        assertSnapshot(matching: movieListViewController, as: .image, named: "MovieListView_controller", testName: "ListViewController")
    }

}
