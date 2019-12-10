//
//  MyMovieListItem.swift
//  MovieBoard
//
//  Created by itct on 2019/12/10.
//  Copyright © 2019 Naryu. All rights reserved.
//

import Foundation


struct MyMovieListItem: Codable {
    
    var title: String
    var link: String
    var image: String
    var subtitle: String
    var pubDate: String
    var director: String
    var actor: String
    var userRating: String

    func saveItem(){
        DataManager.save(self, with: title)
        
}
    func deletItem(){
        DataManager.delet(title)
        
}
    
}
