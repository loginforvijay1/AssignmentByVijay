//
//  MovieListViewModelTests.swift
//  LloydsCodingAssignmentTests
//
//  Created by Vemireddy Vijayasimha Reddy on 02/01/24.
//

import XCTest

final class MovieListViewModelTests: XCTestCase {
    
    private var service: MockMovieService!
    private var listViewModel: MovieListViewModel!
    
    override func setUpWithError() throws {
        service = MockMovieService()
        listViewModel = MovieListViewModel(service: service)
    }
    
    override func tearDownWithError() throws {
        service = nil
        listViewModel = nil
    }
    
    func test_LoadMovies_WhenSuccesful_ReturnsValidMovieViewItems() {
        // Given
        let expectation = self.expectation(description: "Fetch Movies")
        
        guard let movieList: MovieList = TestUtils().loadJson(filename: "moviedb_now_playing") else {
            XCTFail()
            return
        }
        
        service.fetchNowPlayingMoviesGivenValue = movieList
        
        var movieItems: [MovieViewItem]?
        
        // When
        _ = listViewModel.loadMovies()
            .done { items in
                movieItems = items
                expectation.fulfill()
            }
        
        
        //Then
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertEqual(movieItems?.count, 20)
        guard let movieItem = movieItems?[0] else {
            XCTFail()
            return
        }
        
        XCTAssertEqual( movieItem.subTitle, "December 2023")
        XCTAssertEqual( movieItem.title, "Rebel Moon - Part One: A Child of Fire")
    }
    
    func test_LoadMovies_WhenFailed_ReturnsErrorMessage() {
        // Given
        let expectation = self.expectation(description: "Fetch Movies")
        
        service.fetchNowPlayingMoviesGivenValue = nil
        
        var expectedDownloadError: DownloadError?
        
        // When
        listViewModel.loadMovies()
            .catch { error in
                guard let downloadError = error as? DownloadError else { return }
                expectedDownloadError = downloadError
                expectation.fulfill()
            }
        
        //Then
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertEqual(expectedDownloadError?.message, DownloadError.generic.message)
    }
    
    func test_FetchImage_ReturnsUIImage() {
        // Given
        let expectation = self.expectation(description: "Movie Image")
        
        let imageData = TestUtils().loadImageData(filename: "clapboard")
        service.fetchPosterImageReturnValue = imageData
        let movie = Movie(id: 123, title: "title", posterPath: "posterPath", overview: "overview", releaseDate: Date())
        let movieItem = MovieViewItem(movie)
        
        var expetedImage: UIImage?
        //When
        _ = listViewModel.fetchImage(for: movieItem)
            .done { image in
                expetedImage = image
                expectation.fulfill()
            }
        
        //Then
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertNotNil(expetedImage)
    }
}
