//
//  File.swift
//  
//
//  Created by sungwoo.yeo on 2023/01/09.
//

import SwiftUI

struct MovieListView: View {
    @Binding var movieList: Channel?
    @Environment(\.injected) private var diContainer: DIContainer
    
    var body: some View {
        if getMovieList() == nil {
            Text("empty")
        } else {
            List {
                Section(header:Text("Search Result")) {
                    ForEach(getMovieList()!, id: \.self) { elem in
                        NavigationLink(destination: movieDetailView(movie: elem)) {
                            AttributedText(elem.title)
                        }
                    }
                }
            }
            .listStyle(.plain)
        }
    }
}

private extension MovieListView {
    func getMovieList() -> [Movie]? {
        guard movieList != nil else {
            return nil
        }
        
        if movieList!.total <= 0 {
            return nil
        }
        
        return movieList!.items
    }
    
    func movieDetailView(movie: Movie) -> some View {
        MovieView(movie: movie).inject(diContainer)
    }
}

struct MovieListView_Previews: PreviewProvider {
    static var previews: some View {
        MovieListView(movieList: .constant(nil)).inject(.preview)
    }
}

