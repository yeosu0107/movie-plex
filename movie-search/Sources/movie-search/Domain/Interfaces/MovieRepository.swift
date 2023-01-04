//
//  MovieRepository.swift
//  
//
//  Created by sungwoo.yeo on 2023/01/04.
//

import Foundation

protocol MovieRepository: WebRepository {
    func searchMovie(keyword: String) async throws -> Channel
}
