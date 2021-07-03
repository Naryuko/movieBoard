//
//  movify.swift
//  MovieBoard_remaster
//
//  Created by Naryu on 2021/07/03.
//

import SwiftUI

struct Movify: ViewModifier {
    var movieList: [MovieList]
    
    var hasResult: Bool {
        movieList.count > 0
    }
    
    func body (content: Content) -> some View {
        ZStack {
            Text("검색 결과가 없습니다.")
                .opacity(hasResult ? 0 : 1)
            content
                .opacity(hasResult ? 1 : 0)
        }
    }
    
    
}

extension View {
    func movify (movieList: [MovieList]) -> some View {
        self.modifier(Movify(movieList: movieList))
    }
}
