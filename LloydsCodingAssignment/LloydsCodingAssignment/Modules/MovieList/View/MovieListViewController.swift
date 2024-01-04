//
//  MovieListViewController.swift
//  LloydsCodingAssignment
//
//  Created by Vemireddy Vijayasimha Reddy on 02/01/24.
//

import UIKit

final class MovieListViewController: UIViewController {
    
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
    
    var viewModel: MovieListViewModel? {
        didSet {
            if isViewLoaded {
                loadMovies()
            }
        }
    }
    
    private var movieItems: [MovieViewItem] = []
    
    private func flowLayout() -> UICollectionViewFlowLayout {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        flowLayout.minimumInteritemSpacing = 10
        flowLayout.minimumLineSpacing = 20
        flowLayout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        return flowLayout
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = MovieListViewModel(service: MovieService())
        title = viewModel?.title
        collectionView.collectionViewLayout = flowLayout()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(MovieCollectionViewCell.nib, forCellWithReuseIdentifier: MovieCollectionViewCell.reuseIdentifier)
        activityIndicator.style = .large
        activityIndicator.hidesWhenStopped = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(loadMovies))
    }
    
    @objc private func loadMovies() {
        guard let viewModel = viewModel else { return }
        
        disableControls()
        viewModel.loadMovies()
            .done { [weak self] items in
                DispatchQueue.main.async {
                    self?.movieItems = items
                    self?.collectionView.reloadData()
                }
            }
            .catch { [weak self] error in
                guard let downloadError = error as? DownloadError else { return }
                self?.present(withTitle: "Download Error", description: downloadError.message)
            }
            .finally { [weak self] in
                self?.enableControls()
            }
    }
    
    private func enableControls() {
        activityIndicator.stopAnimating()
    }
    
    private func disableControls() {
        activityIndicator.startAnimating()
    }
}

extension MovieListViewController {
    func showMovieDetails(movie: Movie) {
        let viewModel = MovieDetailsViewModel(movie: movie, moviesService: MovieService())
        let viewController = MovieDetailsViewController.instantiate()
        viewController.viewModel = viewModel
        navigationController?.pushViewController(viewController, animated: true)
    }
}
extension MovieListViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let yourWidth = (collectionView.bounds.width - 40)/2
        let yourHeight = yourWidth
        
        return CGSize(width: yourWidth, height: yourHeight)
    }
}

extension MovieListViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let movieCell = cell as? MovieCollectionViewCell else {
            return
        }
        
        let item = movieItems[indexPath.row]
        movieCell.configureContent(item)
        
        _ = viewModel?.fetchImage(for: item)
            .done { [weak self] image in
                if self?.collectionView.indexPath(for: cell) == indexPath {
                    movieCell.updateImage(image: image)
                }
            }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = movieItems[indexPath.row]
        showMovieDetails(movie: item.movie)
    }
}

extension MovieListViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return collectionView.dequeueReusableCell(withReuseIdentifier: MovieCollectionViewCell.reuseIdentifier, for: indexPath)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.movieItems.count
    }
}

extension MovieListViewController: StoryboardBased {
    static var storyboard: Storyboard = .main
}
