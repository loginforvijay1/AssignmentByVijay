

import UIKit

final class MovieDetailsCoordinator: Coordinator {
    var parentCoordinator: Coordinator?
    var childCoordinators: [Coordinator] = []
    
    var navigationController: UINavigationController
    private let movieDetails: MovieDetailsData
    
    init(movieDetails: MovieDetailsData, navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.movieDetails = movieDetails
    }
    
    func start() {
        let viewModel = MovieDetailsViewModel(movieDetails: movieDetails)
        let viewController = MovieDetailsViewController()
        viewController.viewModel = viewModel
        navigationController.pushViewController(viewController, animated: true)
    }
}
