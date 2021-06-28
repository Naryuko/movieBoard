//
//  MovieBoard_remasterApp.swift
//  MovieBoard_remaster
//
//  Created by Naryu on 2021/06/28.
//

import SwiftUI

@main
struct MovieBoard_remasterApp: App {
    let model = MovieBoard()
    var body: some Scene {
        WindowGroup {
            MovieBoardView(model: model)
        }
    }
}
