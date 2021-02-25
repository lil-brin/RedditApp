//
//  Coordinator.swift
//  RedditApp
//
//  Created by iceice on 2/13/21.
//

import Foundation

import UIKit

protocol Coordinator {
    
    var navController: UINavigationController { get set }
    
    var childCoordinators: [Coordinator] { get set }
    
    func start()
}
