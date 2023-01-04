//
//  MovieRepository.swift
//  
//
//  Created by sungwoo.yeo on 2023/01/04.
//

import Foundation

final class DefaultMovieRepository: MovieRepository {
    let session: URLSession
    let baseURL: String
    
    init() {
        self.session = URLSession(configuration: .default)
        self.baseURL = "https://openapi.naver.com"
    }
    
    func searchMovie(keyword: String) async throws -> Channel {
        let movieAPI = MovieAPI(keyword: keyword)
        let jsonString =  try await request(apiCall: movieAPI)
        guard let jsonObject = jsonString.data(using: .utf8) else {
            throw APIError.parseError
        }
        return try JSONDecoder().decode(Channel.self, from: jsonObject)
    }
}
