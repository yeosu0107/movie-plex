//
//  MovieInteractor.swift
//  movieplex
//
//  Created by sungwoo.yeo on 2022/12/14.
//

import Foundation
import SwiftUI

protocol MovieInteractor {
    func search(keyword: String, movieList: LoadableObject<Channel>)
}

struct MovieInteractorImpl : MovieInteractor {
    let movieRepository: MovieRepository
    
    init(movieRepository: MovieRepository) {
        self.movieRepository = movieRepository
    }
    
    func search(keyword: String, movieList: LoadableObject<Channel>) {
        let cancelBag = CancelBag()
        movieList.wrappedValue.setIsLoading(cancelBag: cancelBag)
        movieRepository.searchMovie(keyword: keyword)
            .sink(receiveCompletion: { completion in
                switch completion {
                case let .failure(error):
                    movieList.wrappedValue.setFail(error: error)
                default:
                    break
                }
            }, receiveValue: { jsonString in
                do {
                    let jsonObject = jsonString.data(using: .utf8)!
                    let channel = try JSONDecoder().decode(Channel.self, from: jsonObject)
                    movieList.wrappedValue = .loaded(channel)
                } catch {
                    movieList.wrappedValue.setFail(error: error)
                }
            })
            .store(in: cancelBag)
    }
}
