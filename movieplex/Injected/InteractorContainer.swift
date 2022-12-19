//
//  InteractorContainer.swift
//  movieplex
//
//  Created by sungwoo.yeo on 2022/12/19.
//

extension DIContainer {
    struct Interactors {
        let movieInteractor: MovieInteractor
        
        init(movieInteractor: MovieInteractor) {
            self.movieInteractor = movieInteractor
        }
        
        static var stub: Self {
            .init(movieInteractor: StubMovieInteractor())
        }
    }
}
