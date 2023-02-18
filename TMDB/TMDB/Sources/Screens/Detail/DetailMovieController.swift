//
//  DetailMovieController.swift
//  TMDB
//
//  Created by jc.kim on 2/18/23.
//

import UIKit

class DetailMovieController: UITabBarController {
    
    // MARK: - Views
    
    private let imageView = UIImageView()
    private let name = UILabel()
    private let tagline = UILabel()
    private let info = UILabel()
    private let overview = UILabel()
    private let moveButton = UIButton(type: .custom)
    private let emptyView = UIView()
    private var stackView = UIStackView()
    let id: Int
    private let service: MoviesServiceType
    private var posterPath: String?
    
    // MARK: LifeCycle
    
    init(service: MoviesServiceType, with id: Int) {
        self.service = service
        self.id = id
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addAttributes()
        addSubviews()
        addConstraints()
        loadTableView()
    }
    
    // MARK: - Methods
    
    func addAttributes() {
        view.backgroundColor = .white
        
        hidesBottomBarWhenPushed = true
        tabBar.isHidden = true
        
        imageView.layer.cornerRadius = 5
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.backgroundColor = .lightGray
        
        name.font = UIFont.preferredFont(forTextStyle: .title3)
        name.textColor = .label
        
        tagline.font = UIFont.preferredFont(forTextStyle: .body)
        tagline.textColor = .label
        
        info.font = UIFont.preferredFont(forTextStyle: .subheadline)
        info.numberOfLines = 2
        info.textColor = .label
        
        overview.font = UIFont.preferredFont(forTextStyle: .subheadline)
        overview.textColor = .secondaryLabel
        overview.numberOfLines = 0
        
        moveButton.setTitle("포스터 보러가기", for: .normal)
        moveButton.setTitleColor(.white, for: .normal)
        moveButton.backgroundColor = .systemBlue
        moveButton.addTarget(self, action: #selector(open), for: .touchUpInside)
        
        stackView = UIStackView(arrangedSubviews: [imageView, name, tagline, info, overview, moveButton, emptyView])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 10
        stackView.axis = .vertical
    }
    
    func addSubviews() {
        view.addSubview(stackView)
    }
    
    func addConstraints() {
        emptyView.setContentHuggingPriority(.defaultLow, for: .vertical)
        
        NSLayoutConstraint.activate([
            moveButton.heightAnchor.constraint(equalToConstant: 50),
            
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        stackView.setCustomSpacing(20, after: imageView)
        stackView.setCustomSpacing(20, after: overview)
    }
    
    private func fetchData(completion: @escaping (Result<MovieDetail, NetworkError>) -> Void) {
        Task(priority: .background) {
            let result = await service.detail(id: self.id)
            completion(result)
        }
    }
    
    func loadTableView(completion: (() -> Void)? = nil) {
        fetchData { response in
            switch response {
            case .success(let movieDetail):
                self.configure(with: movieDetail)
                self.posterPath = movieDetail.posterPath
            case .failure(let error):
                self.showModal(title: "Error", message: error.description)
            }
            completion?()
        }
        
    }
    
    func configure(with movie: MovieDetail) {
        name.text = movie.title
        tagline.text = movie.tagline
        info.text = "| ⭐️\(movie.voteAverage) | \(movie.releaseDate) | \(movie.runtime ?? 0)분 | \(movie.genres.map { $0.name }.joined(separator: ", ")) |"
        overview.text = movie.overview
    }
    
    @objc func open() {
        if let url = URL(string: ApiConstants.originalImageUrl + (posterPath ?? "")) {
            UIApplication.shared.open(url)
        }
    }
}
