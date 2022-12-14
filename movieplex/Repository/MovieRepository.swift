//
//  movieRepository.swift
//  movieplex
//
//  Created by sungwoo.yeo on 2022/12/12.
//

import Combine
import Foundation

struct MovieRepository : WebRepository {
    let session: URLSession
    let baseURL: String
    let bgQueue = DispatchQueue(label: "bg_parse_queue")
    
    init() {
        self.session = URLSession(configuration: .default)
        self.baseURL = "https://openapi.naver.com"
    }
    
    func searchMovie(keyword: String) -> AnyPublisher<String, Error> {
        let movieAPI = MovieAPI(keyword: keyword)
        return request(apiCall: movieAPI)
    }
}


struct MovieAPI: APICall {
    var keyword: String
    
    init(keyword: String) {
        self.keyword = keyword
    }
    
    var path: String {
        return "/v1/search/movie.json"
    }
    
    var method: String {
        return "GET"
    }
    
    var headers: [String: String]? {
        return [
            "X-Naver-Client-Id":"",
            "X-Naver-Client-Secret":""
        ]
    }
    
    var query: [String : String]? {
        return [
            "query":keyword
        ]
    }
    
    func body() throws -> Data? {
        return nil
    }
}
