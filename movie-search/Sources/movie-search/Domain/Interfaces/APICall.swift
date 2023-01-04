//
//  APICall.swift
//  
//
//  Created by sungwoo.yeo on 2023/01/04.
//

import Foundation

protocol APICall {
    var path: String { get }
    var method: String { get }
    var headers: [String: String]? { get }
    var query: [String: String]? { get }
    func body() throws -> Data?
}

extension APICall {
    func urlRequest(baseURL: String) throws -> URLRequest {
        var queryString: String = ""
        query?.forEach{ elem in
            queryString+="\(elem.key)=\(elem.value)"
        }
        
        guard let url = URL(string: baseURL + path + (queryString == "" ? "" : "?" + queryString)) else {
            throw APIError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method
        request.allHTTPHeaderFields = headers
        request.httpBody = try body()
                
        return request
    }
}

