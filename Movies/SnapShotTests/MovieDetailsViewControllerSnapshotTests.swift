//
//  MovieDetailsViewControllerSnapshotTests.swift
//  MoviesTests
//
//  Created by Vemireddy Vijayasimha Reddy on 29/01/24.
//

import XCTest
import SnapshotTesting
@testable import Movies

final class MovieDetailsViewControllerSnapshotTests: XCTestCase {

    override func setUpWithError() throws {
        // Set the isRecording  to true initially to generate reference snapshots
        // isRecording = true
        isRecording = false
    }
    
    func testMovieListViewController(){
        let movieDetailsViewController = MovieDetailsViewController()
        assertSnapshot(matching: movieDetailsViewController, as: .image, named: "MovieDetailsView_controller", testName: "DetailsViewController")
    }
}
