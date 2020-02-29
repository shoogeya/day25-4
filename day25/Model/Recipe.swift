//
//  Recipe.swift
//  day25
//
//  Created by Abdullah Ayyad on 23/10/2019.
//  Copyright © 2019 Abdullah Ayyad. All rights reserved.
//

import Foundation
class Recipe: Codable {
        let id: Int
        let type, slug: String
        let url: String
        let status, title, titlePlain, excerpt: String
        let date, modified: String
        //let categories: [String]?
        let author: String
        let commentCount: Int
        let commentStatus: String
        let thumbnail: String?
        let mainImage: String
        let preparePeriod: String?
        let like, dislike: Int
        let isLike, isDislike: Bool?
        let isFavourite :Bool?
        let components :[String]?
        let content :String?
        enum CodingKeys: String, CodingKey {
            case id, type, slug, url, status, title
            case titlePlain = "title_plain"
            case excerpt, date, modified, author
            case commentCount = "comment_count"
            case commentStatus = "comment_status"
            case thumbnail
            case mainImage = "main_image"
            case preparePeriod = "prepare_period"
            case like, dislike
            case isFavourite = "is_favourite"
            case isLike = "is_like"
            case isDislike = "is_dislike"
            case components
            case content
        }

        init(id: Int, type: String, slug: String, url: String, status: String, title: String, titlePlain: String, excerpt: String, date: String, modified: String, categories: [String], author: String, commentCount: Int, commentStatus: String, thumbnail: String?, mainImage: String, preparePeriod: String?, like: Int, dislike: Int, isFavourite: Bool, isLike: Bool, isDislike: Bool) {
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
            //self.categories = categories
            self.author = author
            self.commentCount = commentCount
            self.commentStatus = commentStatus
            self.thumbnail = thumbnail
            self.mainImage = mainImage
            self.preparePeriod = preparePeriod
            self.like = like
            self.dislike = dislike
            self.isFavourite = isFavourite
            self.isLike = isLike
            self.isDislike = isDislike
            self.components = []
            self.content = ""
        }
    }
