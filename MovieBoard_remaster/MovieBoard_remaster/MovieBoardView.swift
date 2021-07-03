//
//  ContentView.swift
//  MovieBoard_remaster
//
//  Created by Naryu on 2021/06/28.
//

import SwiftUI

struct MovieBoardView: View {
    @ObservedObject var model: MovieBoard
    @State var title: String = ""
    
    var body: some View {
        VStack {
            SearchBar(title: $title)
                .onChange(of: title) { title in
                    model.search(for: title)
                }
            body(movieList: model.movieList)
        }
    }
    
    func body (movieList: [MovieList]) -> some View {
        GeometryReader { geomtery in
            NavigationView {
                List {
                    ForEach(model.movieList) {movie in
                        movieCell(movieDetail: movie)
                    }
                }
            }.movify(movieList: model.movieList)
        }
    }

    
}

struct movieCell: View  {
    var movieDetail: MovieList
    
    var body: some View {
        NavigationLink(destination: DetailMovie(movie: movieDetail)) {
            HStack {
                Image(uiImage: Function.str2img(from: movieDetail.image))
                    .resizable()
                    .frame(width: 40, height: 60)
                Text(movieDetail.title)
            }
        }
        .navigationTitle("")
        .navigationBarHidden(true)
    }
    
    
    
}

struct SearchBar: View {
    @Binding var title: String
    
    var body: some View {
        TextField("검색할 영화 제목을 입력하세요.", text: $title)
            .padding(pad)
            .padding(.horizontal, horizontalPad)
            .background(Color(.systemGray6))
            .cornerRadius(radius)
    }
    
    // MARK: Drawing Factor
    
    let pad: CGFloat = 8
    let horizontalPad: CGFloat = 20
    let radius: CGFloat = 10
}



struct DetailMovie: View {
    var movie: MovieList
    
    var body: some View {
        Text("wow")
    }
    
    
}
