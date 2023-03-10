//
//  TrendCoordinator.swift
//  TMDB
//
//  Created by jc.kim on 3/2/23.
//

import Foundation
import UIKit

class TrendCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let vc = TrendMovieController(service: MoviesService())
        vc.tabBarItem = UITabBarItem(title: "트렌드", image: UIImage(systemName: "t.circle"), selectedImage: nil)
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
}
