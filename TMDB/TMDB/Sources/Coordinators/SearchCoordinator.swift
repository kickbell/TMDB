//
//  SearchCoordinator.swift
//  TMDB
//
//  Created by jc.kim on 3/2/23.
//

import Foundation
import UIKit

class SearchCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let vc = SearchMovieController(service: MoviesService())
        vc.tabBarItem = UITabBarItem(title: "검색", image: UIImage(systemName: "magnifyingglass"), selectedImage: nil)
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
    
    func detail(_ id: Int) {
        let vc = DetailMovieController(service: MoviesService(), with: id)
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController.pushViewController(vc, animated: true)
    }
}
