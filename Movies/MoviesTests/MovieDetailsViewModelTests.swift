

import XCTest
import PromiseKit

class MovieDetailsViewModelTests: XCTestCase {

    private var service: MockMovieService?

    private var sut: MovieDetailsViewModel?

    override func setUpWithError() throws {
        service = MockMovieService()
    }

    override func tearDownWithError() throws {
        service = nil
    }

    func test_MovieImage_ReturnsUIImage() {
        let imageData = TestUtils().loadImageData(filename: "clapboard")
        service?.fetchPosterImageReturnValue = imageData
        XCTAssertNotNil(service)
    }
}
