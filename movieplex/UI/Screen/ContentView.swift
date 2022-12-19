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

    init() {
        self._movieList = .init(initialValue: .notRequested)
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
                VStack(alignment:.leading) {
                    Text(firstItem()?.title ?? "").font(.title)
                    Text(firstItem()?.subtitle ?? "").font(.subheadline)
                    HStack(spacing: 10) {
                        Text(firstItem()?.pubDate ?? "")
                        Text(firstItem()?.director ?? "")
                        Text(firstItem()?.userRating ?? "")
                    }.font(.callout)
                    Text(firstItem()?.actor ?? "").font(.body)
                }
                
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
    
    func firstItem() -> Movie? {
        if(movieList.value == nil) {
            return nil
        }
        
        if(movieList.value!.items.count <= 0) {
            return nil
        }
        
        return movieList.value?.items[0]
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
