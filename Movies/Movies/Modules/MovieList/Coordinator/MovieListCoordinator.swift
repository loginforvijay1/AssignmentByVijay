

import UIKit

protocol  MovieListCoordinatorDelegate: AnyObject {
    func showMovieDetails(movieDetails: MovieDetailsData)
}

final class MovieListCoordinator: Coordinator {
    var navigationController: UINavigationController
    
    var parentCoordinator: Coordinator?
    var childCoordinators: [Coordinator] = []
    
    private let service: MovieService
    
    init(navigationController: UINavigationController, service: MovieService = MovieService()) {
        self.navigationController = navigationController
        self.service = service
    }
    
    func start() {
        let viewModel = MovieListViewModel(service: service, delegate: self)
        let viewController = MovieListViewController()
        viewController.viewModel = viewModel
        navigationController.viewControllers = [viewController]
    }
}

extension MovieListCoordinator: MovieListCoordinatorDelegate {
    func showMovieDetails(movieDetails: MovieDetailsData) {
        let coordinator = MovieDetailsCoordinator(movieDetails: movieDetails, navigationController: navigationController)
        coordinator.parentCoordinator = self
        childCoordinators.append(coordinator)
        coordinator.start()
    }
}
