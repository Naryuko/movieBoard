//
//  Jason.swift
//  MovieBoard
//
//  Created by Naryu on 2019/11/17.
//  Copyright © 2019 Naryu. All rights reserved.
//

import Foundation
import UIKit

struct movieData: Decodable {
    
    let title: String
    let link: String
    let image: String
    let subtitle: String
    let pubDate: String
    let director: String
    let actor: String
    let userRating: String
}

struct totalData: Decodable {
    
    let lastBuildDate: String
    let total: Int
    let start: Int
    let display: Int
    let items: [movieData]
    
}

struct searchResult: Decodable {
    let totalData: totalData
}


class movieList: Codable{
    var title: String
    var link: String
    var image: String
    var subtitle: String
    var pubDate: String
    var director: String
    var actor: String
    var userRating: String
    var comment: String
    
    init(title: String, link: String, image: String, subtitle: String, pubDate: String, director: String, actor: String, userRating: String, comment: String) {
        self.title = title
        self.link = link
        self.image = image
        self.subtitle = subtitle
        self.pubDate = pubDate
        self.director = director
        self.actor = actor
        self.userRating = userRating
        self.comment = comment
    }
        func saveItem(){
            DataManager.save(self, with: title)
            
    }
        func deletItem(){
            DataManager.delet(title)
            
    }
    
}
