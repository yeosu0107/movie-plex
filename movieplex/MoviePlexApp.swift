//
//  movieplexApp.swift
//  movieplex
//
//  Created by sungwoo.yeo on 2022/12/12.
//

import SwiftUI
import movie_search

@main
struct MoviePlexApp: App {
    var body: some Scene {
        WindowGroup {
            openSearchView()
        }
    }
}

extension MoviePlexApp {
    private func openSearchView() -> some View {
        let movieMgr = MovieSearchManager()
        return movieMgr.launch()
    }
}
