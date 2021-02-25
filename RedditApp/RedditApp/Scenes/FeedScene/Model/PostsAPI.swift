//
//  PostsAPI.swift
//  RedditApp
//
//  Created by iceice on 2/23/21.
//

import Foundation

class PostsAPI {
    var count = 0
    var lastFetched: String?
    let pageSize = 20
    
    func fetchPosts(completion: @escaping ([Post]?, Error?) -> Void) {
        let endpoint = Endpoint.bestPosts(limit: pageSize, count: count, after: lastFetched)
        
        PostService.fetchPosts(endpoint: endpoint) { (response, error) in
            guard error == nil else {
                completion(nil, error)
                return
            }
            
            guard let response = response else {
                let error = NSError(domain: "Data error domain. Network unavailable.", code: -7000, userInfo: nil)
                completion(nil, error)
                return
            }
            
            self.lastFetched = response.data.after
            self.count += response.data.dist
            
            let posts = response.data.children.map { $0.data }
            completion(posts, nil)
        }
    }
}
