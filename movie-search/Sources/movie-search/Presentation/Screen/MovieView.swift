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
    }
    
    var body: some View {
        if #available(iOS 15.0, *) {
            movieDetail.task {
                loadImge()
            }
        } else {
            movieDetail.onAppear {
                loadImge()
            }
        }
    }
    
    var movieDetail: some View {
        VStack {
            Spacer()
            
            if posterImg != nil {
                Image(uiImage: posterImg!)
            } else {
                if #available(iOS 14.0, *) {
                    ProgressView().progressViewStyle(CircularProgressViewStyle())
                } else {
                    ActivityIndicator(isAnimating: true)
                }
            }
            
            Spacer()
            
            VStack(alignment: .leading) {
                AttributedText(movie.title).font(.system(size:22, weight: .regular))
                
                HStack {
                    Text("(\(movie.pubDate))")
                    Text(" | ")
                    Text("\(movie.userRating) / 10.0")
                }
                
                if movie.director.count > 0 {
                    HStack {
                        Text("감독: ")
                        Text(movie.director.dropLast(1).replacingOccurrences(of: "|", with: " | "))
                    }
                }
                
                if movie.actor.count > 0 {
                    HStack {
                        Text("출연: ")
                        Text(movie.actor.dropLast(1).replacingOccurrences(of: "|", with: " | "))
                    }
                }
            }
            
            Spacer()
            Spacer()
            
        }.frame(width: 320, height: 640)
    }
}

extension MovieView {
    func loadImge() {
        Task {
            do {
                print("loading image: \(movie.image)")
                posterImg = try await diContainer.containers.imageContainer.load(url: movie.image)
            } catch {
                print("fail to load image: \(error)")
            }
        }
    }
}



struct MovieView_Previews: PreviewProvider {
    static var previews: some View {
        MovieView(movie: Movie(title: "title", link: "1", image: "imageLink", subtitle: "subTitle", pubDate: "2023", director: "director,", actor: "actor,", userRating: "1")).inject(.preview)
    }
}
