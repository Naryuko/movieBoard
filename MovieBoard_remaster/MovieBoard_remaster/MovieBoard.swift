//
//  MovieBoard.swift
//  MovieBoard_remaster
//
//  Created by Naryu on 2021/06/28.
//

import Foundation

class MovieBoard: ObservableObject {
    @Published var model = MovieBoardModel()
    let naverAPI: NaverAPI
    
    init () {
        self.naverAPI = NaverAPI()
    }
    
    var movieList: [MovieList] {
        self.model.movieList
    }
    
    func search (for title: String) {
        naverAPI.search(for: title) { results, errorMessage in
            if let results = results {
                self.model.movieList = results
            }
        }
    }
    
    
    
    
}
