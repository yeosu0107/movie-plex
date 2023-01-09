//
//  File.swift
//  
//
//  Created by sungwoo.yeo on 2023/01/09.
//

import SwiftUI

struct MovieListView: View {
    @Binding var movieList: Channel?
    
    var body: some View {
        if getMovieList() == nil {
            Text("empty")
        } else {
            List {
                Section(header:Text("Search Result")) {
                    ForEach(getMovieList()!, id: \.self) { elem in
                        NavigationLink(elem.title, destination: MovieView(movie: elem))
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
}

struct MovieListView_Previews: PreviewProvider {
    static var previews: some View {
        MovieListView(movieList: .constant(nil))
    }
}

