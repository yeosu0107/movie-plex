//
//  MovieListView.swift
//  movieplex
//
//  Created by sungwoo.yeo on 2022/12/22.
//

import SwiftUI

struct MovieListView: View {
    @Binding var movieList: Loadable<Channel>
    
    var body: some View {
        if getMovieList() == nil {
            Text("empty")
        } else {
            List {
                Section(header:Text("Search Result")) {
                    ForEach(0..<getReturnedMovieList(), id: \.self) { i in
                        NavigationLink(getMovieList()![i].title, destination: MovieView(movie: (movieList.value?.items[i])!))
                    }
                }
            }
            .listStyle(.plain)
        }
        
    }
}

private extension MovieListView {
    func getMovieList() -> [Movie]? {
        if movieList.value == nil {
            return nil
        }
        
        if(movieList.value!.total <= 0) {
            return nil
        }
        
        return movieList.value!.items
    }
    
    func getReturnedMovieList() -> Int {
        return movieList.value?.display ?? 0
    }
}

struct MovieListView_Previews: PreviewProvider {
    static var previews: some View {
        MovieListView(movieList: .constant(.notRequested))
    }
}
