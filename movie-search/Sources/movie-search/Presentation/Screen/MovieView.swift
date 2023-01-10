//
//  File.swift
//  
//
//  Created by sungwoo.yeo on 2023/01/09.
//

import SwiftUI

struct MovieView: View {
    let movie: Movie
    @State var posterImg: UIImage?
    @Environment(\.injected) private var diContainer: DIContainer
    
    init(movie: Movie) {
        self.movie = movie
        self.posterImg = nil
        
        loadImge()
    }
    
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
            
            if posterImg != nil {
                Image(uiImage: posterImg!).resizable()
            }
        }
    }
}

extension MovieView {
    func loadImge() {
        Task {
            do {
                print("before load image: \(movie.image)")
                posterImg = try await diContainer.containers.imageContainer.load(url: movie.image)
            } catch {
                print(error)
            }
        }
    }
}

struct MovieView_Previews: PreviewProvider {
    static var previews: some View {
        MovieView(movie: Movie(title: "1", link: "1", image: "1", subtitle: "1", pubDate: "1", director: "1", actor: "1", userRating: "1")).inject(.preview)
    }
}
