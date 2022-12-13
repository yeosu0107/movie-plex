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
    
    init(session: URLSession, baseURL: String) {
        self.session = session
        self.baseURL = baseURL
    }
    
    func searchMovie() -> AnyPublisher<String, Error> {
        let urlRequest = URLRequest(url: URL(string: baseURL)!)
        return request(endpoint: API.search)
        
    }
}

extension MovieRepository {
    enum API {
        case search
    }
}

extension MovieRepository.API: APICall {
    var path: String {
        switch self {
        case .search:
            return "/v1/search/movie.json"
        }
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
    
    func body() throws -> Data? {
        return nil
    }
}
