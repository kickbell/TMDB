//
//  MainTabBarController.swift
//  TMDB
//
//  Created by jc.kim on 2/18/23.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    // MARK: Properties
    let store = StoreCoordinator(navigationController: UINavigationController())
    let search = SearchCoordinator(navigationController: UINavigationController())
    let trend = TrendCoordinator(navigationController: UINavigationController())
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        addAttribues()
        addViewControllers()
    }
    
    // MARK: - Methods
    
    func configure() {
        store.start()
        search.start()
        trend.start()
    }
    
    func addAttribues() {
        self.tabBar.tintColor = .label
        self.tabBar.barStyle = .default
    }
    
    func addViewControllers() {
        self.viewControllers = [
            store.navigationController,
            search.navigationController,
            trend.navigationController
        ]
    }
}
