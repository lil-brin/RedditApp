//
//  PostService.swift
//  RedditApp
//
//  Created by iceice on 2/23/21.
//

import Foundation

class PostService {
    
    static func fetchPosts(endpoint: Endpoint, completion: @escaping (APIResponse?, Error?) -> Void) {
        
        let task = URLSession.shared.dataTask(with: endpoint.url) { data, response, error in
            guard error == nil else {
                completion(nil, error)
                return
            }

            do {
                let apiResponse = try JSONDecoder().decode(APIResponse.self, from: data! )
                completion(apiResponse, nil)
            } catch {
                debugPrint(error)
                completion(nil, error)
            }
        }
        task.resume()
    }
}
