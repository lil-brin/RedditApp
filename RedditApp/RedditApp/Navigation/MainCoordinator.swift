//
//  MainCoordinator.swift
//  RedditApp
//
//  Created by iceice on 2/13/21.
//

import Foundation
import UIKit

class MainCoordinator: Coordinator {
    
    var childCoordinators = [Coordinator]()
    
    var navController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navController = navigationController
    }
    
    func start() {
        let vc = FeedViewController.instantiate()
        vc.coordinator = self
        navController.pushViewController(vc, animated: false)
    }
}
