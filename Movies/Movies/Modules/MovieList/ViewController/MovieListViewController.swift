

import UIKit
import SwiftUI

final class MovieListViewController: UIViewController {
    
    private var collectionView: UICollectionView?
    private var activityIndicator: UIActivityIndicatorView?
    var viewModel: MovieListViewModelType? {
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
        flowLayout.minimumInteritemSpacing = 5
        flowLayout.minimumLineSpacing = 5
        flowLayout.sectionInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        return flowLayout
    }
    
    private func setupCollectionView() {
        collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height), collectionViewLayout: flowLayout())
        collectionView?.collectionViewLayout = flowLayout()
        collectionView?.delegate = self
        collectionView?.dataSource = self
        collectionView?.register(UICollectionViewCell.self, forCellWithReuseIdentifier: Constants.movieListCellIdentifier)
        view.addSubview(collectionView ?? UICollectionView())
        collectionView?.translatesAutoresizingMaskIntoConstraints = false
        collectionView?.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        collectionView?.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        collectionView?.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        collectionView?.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
    }
    
    private func setupActivityIndicator() {
        activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator?.center = self.view.center
        activityIndicator?.hidesWhenStopped = true
        activityIndicator?.color = UIColor.blue
        view.addSubview(activityIndicator ?? UIActivityIndicatorView())
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        setupActivityIndicator()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(loadMovies))
        title = viewModel?.title
        loadMovies()
    }
    
    @objc private func loadMovies() {
        guard let viewModel = viewModel else { return }
        
        disableControls()
        viewModel.loadMovies()
            .done { [weak self] items in
                DispatchQueue.main.async {
                    self?.movieItems = items
                    self?.collectionView?.reloadData()
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
        activityIndicator?.stopAnimating()
    }
    
    private func disableControls() {
        activityIndicator?.startAnimating()
    }
}

extension MovieListViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let yourWidth = (collectionView.bounds.width - 15)/2
        let yourHeight = yourWidth + 30
        
        return CGSize(width: yourWidth, height: yourHeight)
    }
}

extension MovieListViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard movieItems.indices.contains(indexPath.row) else { return }
        let item = movieItems[indexPath.row]
        _ = viewModel?.fetchImage(for: item)
            .done { [weak self] image in
                if self?.collectionView?.indexPath(for: cell) == indexPath {
                    cell.contentConfiguration = UIHostingConfiguration {
                        MovieListCell(movieImage: image, title: item.title, subTitile: item.subTitle)
                    }
                }
            }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard movieItems.indices.contains(indexPath.row) else { return }
        let item = movieItems[indexPath.row]
        let moviePoster = viewModel?.cache.object(forKey: item.movie.posterPath as NSString) ?? UIImage()
        viewModel?.didSelect(movieDetails: MovieDetailsData(movieData: item.movie, moviePoster: moviePoster))
    }
}

extension MovieListViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let movieCell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.movieListCellIdentifier, for: indexPath)
        movieCell.layer.cornerRadius = 10
        movieCell.layer.borderWidth = 1.0
        movieCell.layer.borderColor = UIColor.clear.cgColor
        movieCell.layer.masksToBounds = true
        return movieCell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.movieItems.count
    }
}
