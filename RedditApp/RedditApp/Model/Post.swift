//
//  Post.swift
//  RedditApp
//
//  Created by iceice on 2/23/21.
//

import Foundation

struct Post: Codable, Hashable {
    let identifier = UUID()
    let name: String
    let title: String
    let author: String
    let ups: Int
    let subreddit: String
    let thumbnail: String?
    let thumbnailWidth: Int?
    let thumbnailHeight: Int?
    let created: Double
    let numComments: Int
    var wasRead: Bool = false
    let images: PostImages?
    
    private enum CodingKeys: String, CodingKey {
        case name, title, author, ups, subreddit, thumbnail
        case thumbnailWidth = "thumbnail_width"
        case thumbnailHeight = "thumbnail_height"
        case created = "created_utc"
        case numComments = "num_comments"
        case images = "preview"
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(identifier)
        hasher.combine(wasRead)
    }

    static func == (lhs: Post, rhs: Post) -> Bool {
        return lhs.identifier == rhs.identifier
            && lhs.wasRead == rhs.wasRead
    }
}

struct PostImages: Codable {
    let images: [PostImage]
}

struct PostImage: Codable {
    let source: ImageData
}

struct ImageData: Codable {
    let url: String
    let width: Float
    let height: Float
}

struct APIResponse: Codable {
    let kind: Kind
    let data: ResponseData
}

struct ResponseData: Codable {
    let modhash: String
    let dist: Int
    let children: [Child]
    let after: String?
    let before: String?
}

struct Child: Codable {
    let kind: Kind
    let data: Post
}

enum Kind: String, Codable {
    case listing = "Listing"
    case comment = "t1"
    case account = "t2"
    case link = "t3"
    case message = "t4"
    case subreddit = "t5"
    case award = "t6"
    case more = "more"
}
