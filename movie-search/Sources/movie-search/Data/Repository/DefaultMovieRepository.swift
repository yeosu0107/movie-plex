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
        let data =  try await request(request: movieAPI.urlRequest(baseURL: baseURL))
        let jsonString = String(decoding: data, as: UTF8.self)
        guard let jsonObject = jsonString.data(using: .utf8) else {
            throw APIError.parseError
        }
        return try JSONDecoder().decode(Channel.self, from: jsonObject)
    }
}
