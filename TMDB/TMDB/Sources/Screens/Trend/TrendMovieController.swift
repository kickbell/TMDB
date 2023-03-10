//
//  TrendMovieController.swift
//  TMDB
//
//  Created by jc.kim on 2/18/23.
//

import UIKit

class TrendMovieController: UIViewController {
    
    // MARK: - Views
    
    private let poster = UIImageView()
    private let largeTitle = UILabel()
    private let shuffleButton = UIButton()
    private let subtitle = UILabel()
    private let name = UILabel()
    private let info = UILabel()
    private let overview = UILabel()
    private let moveButton = UIButton(type: .custom)
    private let emptyView = UIView()
    private var innerStackView = UIStackView()
    private var outerStackView = UIStackView()
    private let id: Int = 299536
    private let service: MoviesServiceType
    private var trending: [Movie] = []
    private var posterPath: String?
    
    // MARK: Properties
    weak var coordinator: TrendCoordinator?
    
    // MARK: LifeCycle
    
    init(service: MoviesServiceType) {
        self.service = service
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
        
        largeTitle.text = "트렌드"
        largeTitle.font = UIFontMetrics.default.scaledFont(for: UIFont.systemFont(ofSize: 34, weight: .heavy))
        
        shuffleButton.setImage(UIImage(systemName: "arrow.clockwise", withConfiguration: UIImage.SymbolConfiguration(font: UIFont.systemFont(ofSize: 25))), for: .normal)
        shuffleButton.addTarget(self, action: #selector(refresh), for: .touchUpInside)
        
        subtitle.font = UIFont.preferredFont(forTextStyle: .body)
        subtitle.text = "최근 24시간 동안 트렌드 리스트의 영화를 랜덤으로 나타냅니다. 우측 버튼으로 새로고침 할 수 있습니다."
        subtitle.numberOfLines = 0
        subtitle.textColor = .secondaryLabel
        
        poster.layer.cornerRadius = 5
        poster.contentMode = .scaleAspectFill
        poster.clipsToBounds = true
        
        name.font = UIFont.preferredFont(forTextStyle: .title3)
        name.textColor = .label
        name.accessibilityIdentifier = AccessibilityIdentifiers.Trend.name
        
        info.font = UIFont.preferredFont(forTextStyle: .subheadline)
        info.textColor = .label
        
        overview.font = UIFont.preferredFont(forTextStyle: .subheadline)
        overview.textColor = .secondaryLabel
        overview.numberOfLines = 0
        
        moveButton.setTitle("포스터 보러가기", for: .normal)
        moveButton.setTitleColor(.white, for: .normal)
        moveButton.backgroundColor = .systemBlue
        moveButton.addTarget(self, action: #selector(open), for: .touchUpInside)
        
        innerStackView = UIStackView(arrangedSubviews: [largeTitle, shuffleButton])
        innerStackView.axis = .horizontal
        
        outerStackView = UIStackView(arrangedSubviews: [innerStackView, subtitle, poster, name, info, overview, moveButton, emptyView])
        outerStackView.translatesAutoresizingMaskIntoConstraints = false
        outerStackView.spacing = 10
        outerStackView.axis = .vertical
    }
    
    func addSubviews() {
        view.addSubview(outerStackView)
    }
    
    func addConstraints() {
        emptyView.setContentHuggingPriority(.defaultLow, for: .vertical)
        
        NSLayoutConstraint.activate([
            moveButton.heightAnchor.constraint(equalToConstant: 50),
            
            outerStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            outerStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            outerStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            outerStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        outerStackView.setCustomSpacing(20, after: poster)
        outerStackView.setCustomSpacing(20, after: overview)
    }
    
    private func fetchData(completion: @escaping (Result<Movies, NetworkError>) -> Void) {
        Task(priority: .background) {
            let result = await service.trending()
            completion(result)
        }
    }
    
    func loadTableView(completion: (() -> Void)? = nil) {
        #if UITESTING
            let trending = Movies.loadFromFile("MovieTrend.json", type(of: self))
            self.trending = trending.items
            self.configure(with: trending.items[0])
            self.posterPath = trending.items[0].posterPath
        #else
            fetchData { response in
                switch response {
                case .success(let trending):
                    self.trending = trending.items
                    self.configure(with: trending.items[0])
                    self.posterPath = trending.items[0].posterPath
                case .failure(let error):
                    self.showModal(title: "Error", message: error.description)
                }
                completion?()
            }
        #endif
    }
    
    func configure(with movie: Movie) {
        name.text = movie.title
        info.text = "| ⭐️\(movie.voteAverage) | \(movie.releaseDate) |"
        overview.text = movie.overview
        posterPath = movie.posterPath
        loadImage(from: movie.backdropPath)
    }
    
    private func loadImage(from path: String?) {
        guard let path = path,
              let url = URL(string: ApiConstants.mediumImageUrl + path) else { return }
        ImageLoaderService.shared.loadImage(from: url) { [weak self] result in
            guard let image = try? result.get() else { return }
            DispatchQueue.main.async {
                self?.poster.image = image
            }
        }
    }
    
    @objc func open() {
        if let url = URL(string: ApiConstants.originalImageUrl + (posterPath ?? "")) {
            UIApplication.shared.open(url)
        }
    }
    
    @objc func refresh() {
        configure(with: trending.shuffled()[0])
    }
}
