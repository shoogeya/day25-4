//
//  News.swift
//  day25
//
//  Created by Abdullah Ayyad on 16/10/2019.
//  Copyright © 2019 Abdullah Ayyad. All rights reserved.
//

import Foundation
class News: Codable {
    let id: Int
    let type, slug: String
    let url: String
    let status, title, titlePlain, excerpt: String
    let date, modified, author: String
    let commentCount: Int
    let commentStatus: String
    let mainImage: String?

    enum CodingKeys: String, CodingKey {
        case id, type, slug, url, status, title
        case titlePlain = "title_plain"
        case excerpt, date, modified, author
        case commentCount = "comment_count"
        case commentStatus = "comment_status"
        case mainImage = "main_image"
    }

    init(id: Int, type: String, slug: String, url: String, status: String, title: String, titlePlain: String, excerpt: String, date: String, modified: String, author: String, commentCount: Int, commentStatus: String, mainImage: String?) {
        self.id = id
        self.type = type
        self.slug = slug
        self.url = url
        self.status = status
        self.title = title
        self.titlePlain = titlePlain
        self.excerpt = excerpt
        self.date = date
        self.modified = modified
        self.author = author
        self.commentCount = commentCount
        self.commentStatus = commentStatus
        self.mainImage = mainImage
    }
}
