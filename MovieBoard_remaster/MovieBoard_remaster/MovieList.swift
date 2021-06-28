//
//  MovieList.swift
//  MovieBoard_remaster
//
//  Created by Naryu on 2021/06/28.
//

import Foundation

struct MovieList: Decodable, Identifiable {
    
    let id: Int
    let title: String
    let link: String
    let image: String
    let subtitle: String
    let pubDate: String
    let director: String
    let actor: String
    let userRating: String
    let comment: String
}

struct TotalData: Decodable {
    
    let lastBuildDate: String
    let total: Int
    let start: Int
    let display: Int
    let items: [MovieList]
    
}
