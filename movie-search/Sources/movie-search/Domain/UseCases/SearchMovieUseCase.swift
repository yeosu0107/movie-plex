//
//  SearchMovieUseCase.swift
//  
//
//  Created by sungwoo.yeo on 2023/01/04.
//

import Foundation

protocol SearchMovieUseCase {
    func search(keyword: String) async throws -> Channel
}

final class DefaultSearchMovieUseCase : SearchMovieUseCase {
    
    private let movieRepository: MovieRepository
    
    init(movieRepository: MovieRepository) {
        self.movieRepository = movieRepository
    }
    
    func search(keyword: String) async throws -> Channel {
        return try await movieRepository.searchMovie(keyword: keyword)
    }
}
