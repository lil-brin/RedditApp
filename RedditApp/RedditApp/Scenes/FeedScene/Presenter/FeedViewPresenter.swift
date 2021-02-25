//
//  FeedViewPresenter.swift
//  RedditApp
//
//  Created by iceice on 2/13/21.
//

import Foundation
import UIKit

class FeedViewPresenter {
    
    lazy var postsApi = PostsAPI()
    var posts: [Post] = []
    
    weak var view: FeedView?
    
    init(view: FeedView) {
        self.view = view
    }
    
    func loadView() {
//        self.view?.showLoadingIndicator()
        postsApi.fetchPosts { (posts, error) in
            guard error == nil, let posts = posts else {
                DispatchQueue.main.async {
//                    self.view?.showError(message: "There was an error fetching the posts. Try again later.")
//                    self.view?.hideLoadingIndicator()
                }
                return
            }
            
            self.posts = posts
            DispatchQueue.main.async {
                self.view?.showPosts(self.posts ?? [], animated: false)
            }
        }
    }
    
    func nextPageNeeded() {
        /// Get the next page of posts and update the view
        postsApi.fetchPosts { (posts, error) in
            guard error == nil,
                let posts = posts else {
                DispatchQueue.main.async {
//                    self.view?.showError(message: "There was an error when fetching new Posts. Try again later.")
                }
                return
            }
            
            self.posts.append(contentsOf: posts)
            
            DispatchQueue.main.async {
                self.view?.showPosts(self.posts ?? [], animated: false)
            }
        }
    }
}
