//
//  Coordinator.swift
//  TMDB
//
//  Created by jc.kim on 3/2/23.
//

import Foundation
import UIKit

protocol Coordinator: AnyObject {
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }
    
    func start()
}
