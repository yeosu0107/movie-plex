//
//  SearchView.swift
//  
//
//  Created by sungwoo.yeo on 2023/01/04.
//

import SwiftUI

struct SearchView: View {
    @State private var keyword = ""
    @State private var movieList: Channel?
    @Environment(\.injected) private var diContainer: DIContainer
    
    init() {
        self.movieList = nil
    }
    
    var body: some View {
        NavigationView {
            VStack(alignment: .center) {
                HStack {
                    Image(systemName: "magnifyingglass")
                    TextField("검색어", text: $keyword)
                    Button("검색") {
                        Task {
                            await search()
                        }
                    }.padding()
                }
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
                
                Spacer()
                
                VStack(alignment: .leading) {
                    MovieListView(movieList: $movieList)
                }
                
                Spacer()
            }
        }
        .navigationBarTitle("영화 검색", displayMode: .automatic)
    }
    
    //func NavigationTitleViews(content: ()-> some View) -> some //View {
    //    if #available(iOS 14.0, *) {
    //        return NavigationView{
    //            content
    //        }
    //        .navigationTitle("영화 검색")
    //        .navigationBarTitleDisplayMode(.automatic)
    //    } else {
    //        return NavigationView{
    //            content
    //        }
    //        .navigationBarTitle("영화 검색", displayMode: //.automatic)
    //    }
    //}
}

private extension SearchView {
    func search() async {
        do {
            movieList = try await diContainer.containers.searchMovieContainer.search(keyword: keyword)
        } catch {
            print(error)
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView().inject(.preview)
    }
}

