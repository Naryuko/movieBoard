//
//  ContentView.swift
//  MovieBoard_remaster
//
//  Created by Naryu on 2021/06/28.
//

import SwiftUI

struct MovieBoardView: View {
    @ObservedObject var model: MovieBoard
    
    @State var title: String
    
    var body: some View {
        HStack {
            TextField("Enter the title of movie", text: $title)
            NavigationView {
                List {
                    ForEach(model.movieList) {_ in
                        
                    }
                }
            }
            
            
        }
    }

    
}

struct movieCell: View  {
    var movieDetail: MovieList
    
    var body: some View {
        Text("hello")
    }
}
