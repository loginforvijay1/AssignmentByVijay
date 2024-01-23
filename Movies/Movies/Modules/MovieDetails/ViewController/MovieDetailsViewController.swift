

import Foundation
import UIKit
import PromiseKit

final class MovieDetailsViewController: UIViewController {
    
    private var posterImageView: UIImageView?
    private var titleLabel: UILabel?
    private var subTitleLabel: UILabel?
    private var subTextLabel: UILabel?
    
    var viewModel : MovieDetailsViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = Constants.movieDetailsTitile
        loadViews()
        updateContent()
    }
    
    private func updateContent() {
        guard let viewModel = viewModel else { return }
        titleLabel?.text = viewModel.title
        subTitleLabel?.text = viewModel.subTitle
        subTextLabel?.text = viewModel.subText
        DispatchQueue.main.async { [weak self] in
            self?.posterImageView?.image = viewModel.posterImage
            self?.posterImageView?.showRoundCornersWith(radius: 20)
        }
    }
    
    func loadViews() {
        
        view = UIView()
        view.backgroundColor = .white
        
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing   = 16.0
        
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            stackView.topAnchor.constraint(equalTo: view.topAnchor , constant: 150)
        ])
        posterImageView = UIImageView()
        posterImageView?.heightAnchor.constraint(equalToConstant: 300).isActive = true
        posterImageView?.contentMode = .scaleAspectFit
        stackView.addArrangedSubview(posterImageView ?? UIImageView())
        
        titleLabel = UILabel()
        titleLabel?.translatesAutoresizingMaskIntoConstraints = false
        titleLabel?.font = UIFont.boldSystemFont(ofSize: 22)
        titleLabel?.textAlignment = .center
        titleLabel?.numberOfLines = 0
        stackView.addArrangedSubview(titleLabel ?? UILabel())
        
        subTitleLabel = UILabel()
        subTitleLabel?.translatesAutoresizingMaskIntoConstraints = false
        subTitleLabel?.font = UIFont.systemFont(ofSize: 18)
        subTitleLabel?.textAlignment = .center
        subTitleLabel?.numberOfLines = 0
        stackView.addArrangedSubview(subTitleLabel ?? UILabel())
        
        subTextLabel = UILabel()
        subTextLabel?.translatesAutoresizingMaskIntoConstraints = false
        subTextLabel?.font = UIFont.systemFont(ofSize: 17)
        subTextLabel?.textAlignment = .justified
        subTextLabel?.numberOfLines = 0
        stackView.addArrangedSubview(subTextLabel ?? UILabel())
    }
}
