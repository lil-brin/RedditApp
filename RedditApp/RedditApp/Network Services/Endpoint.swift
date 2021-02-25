//
//  Endpoint.swift
//  RedditApp
//
//  Created by iceice on 2/23/21.
//

import Foundation

struct Endpoint {
    var path: String
    var queryItems: [URLQueryItem] = []
}

extension Endpoint {
    var url: URL {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "reddit.com"
        components.path = path
        components.queryItems = queryItems
        
        guard let url = components.url else {
            preconditionFailure("Invalid URL components: \(components)")
        }
        
        return url
    }
    
    var headers: [String: Any] {
        return [:]
    }
}

extension Endpoint {
    
    static func bestPosts(limit: Int, count: Int, after: String?) -> Self {
        guard let after = after else {
            return Endpoint(path: "/best.json",
                            queryItems: [
                                URLQueryItem(name: "limit",
                                             value: "\(limit)"),
                            ])
        }
        return Endpoint(path: "/best.json",
                        queryItems: [
                            URLQueryItem(name: "limit",
                                         value: "\(limit)"),
                            URLQueryItem(name: "count",
                                         value: "\(count)"),
                            URLQueryItem(name: "after",
                                         value: after)
                        ])
    }
}
