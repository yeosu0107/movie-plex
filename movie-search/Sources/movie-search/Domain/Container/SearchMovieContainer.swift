//
//  SearchMovieUseCase.swift
//  
//
//  Created by sungwoo.yeo on 2023/01/04.
//

import Foundation

protocol SearchMovieContainer {
    func search(keyword: String) async throws -> Channel
}

final class DefaultSearchMovieContainer : SearchMovieContainer {
    
    private let movieRepository: MovieRepository
    
    init(movieRepository: MovieRepository) {
        self.movieRepository = movieRepository
    }
    
    func search(keyword: String) async throws -> Channel {
        return try await movieRepository.searchMovie(keyword: keyword)
    }
}

final class StubSearchMovieContainer : SearchMovieContainer {
    func search(keyword: String) async throws -> Channel {
        return try await Channel(lastBuildDate: "", total: 0, start: 0, display: 0, items: [])
    }
}
