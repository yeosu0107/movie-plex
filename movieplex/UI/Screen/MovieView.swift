//
//  MovieView.swift
//  movieplex
//
//  Created by sungwoo.yeo on 2022/12/22.
//

import SwiftUI

struct MovieView: View {
    var movie: Movie
    
    var body: some View {
        VStack(alignment:.leading) {
            Text(movie.title)
            
            HStack {
                Text(movie.pubDate)
                Text(" | ")
                Text(movie.userRating)
            }
            HStack {
                if movie.director.count > 0 {
                    Text("감독: ")
                    Text(movie.director.dropLast(1).replacingOccurrences(of: "|", with: " | "))
                }
                if movie.actor.count > 0 {
                    Text("|  출연: ")
                    Text(movie.actor.dropLast(1).replacingOccurrences(of: "|", with: " | "))
                }
            }
        }
    }
}

struct MovieView_Previews: PreviewProvider {
    static var previews: some View {
        MovieView(movie: Movie(title: "title", link: "", image: "", subtitle: "", pubDate: "2020", director: "director|", actor: "actor|actor|actor|", userRating: "5.0"))
    }
}
