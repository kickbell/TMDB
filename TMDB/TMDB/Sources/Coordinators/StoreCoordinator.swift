//
//  StoreCoordinator.swift
//  TMDB
//
//  Created by jc.kim on 3/2/23.
//

import Foundation
import UIKit

class StoreCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let vc = MovieStoreController(service: MoviesService())
        vc.tabBarItem = UITabBarItem(title: "스토어", image: UIImage(systemName: "cart"), selectedImage: UIImage(systemName: "cart.fill"))
        vc.tabBarItem.accessibilityIdentifier = AccessibilityIdentifiers.Store.tabBarItem
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
    
    func detail(_ id: Int) {
        let vc = DetailMovieController(service: MoviesService(), with: id)
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController.pushViewController(vc, animated: true)
    }
}
