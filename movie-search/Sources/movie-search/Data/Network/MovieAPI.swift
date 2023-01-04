//
//  MovieAPI.swift
//  
//
//  Created by sungwoo.yeo on 2023/01/04.
//

import Foundation

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
            "query": String(keyword.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")
        ]
    }
    
    func body() throws -> Data? {
        return nil
    }
}
