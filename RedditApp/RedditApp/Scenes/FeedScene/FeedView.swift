//
//  FeedView.swift
//  RedditApp
//
//  Created by iceice on 2/24/21.
//

import Foundation

protocol FeedView: class {
    
    func showPosts(_ posts: [Post], animated: Bool)
    
    func showLoadingIndicator()
    
    func hideLoadingIndicator()
    
    func hideRefreshIndicator()
    
    func showError(message: String)
}
