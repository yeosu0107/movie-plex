//
//  ContentView.swift
//  movieplex
//
//  Created by sungwoo.yeo on 2022/12/12.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.injected) private var injected: DIContainer
    @State private var keyword = ""
    @State private var movieList: Loadable<Channel>

    init(movieList: Loadable<Channel> = .notRequested) {
        self._movieList = .init(initialValue: movieList)
    }
    
    var body: some View {
        NavigationView {
            VStack(alignment: .center) {
                HStack {
                    Image(systemName: "magnifyingglass")
                    TextField("검색어", text: $keyword)
                    Button("검색") {
                        search()
                    }.padding()
                }
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
                Spacer()
            }
            .navigationTitle("영화 검색")
            .navigationBarTitleDisplayMode(.automatic)
        }
    }
}

private extension ContentView {
    func search() {
        injected.interactors.movieInteractor
            .search(
                keyword: keyword,
                movieList: $movieList
            )
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
