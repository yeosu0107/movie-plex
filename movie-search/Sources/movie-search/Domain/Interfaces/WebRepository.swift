//
//  Repository.swift
//  
//
//  Created by sungwoo.yeo on 2023/01/04.
//

import Foundation
import Combine

protocol WebRepository {
    var session: URLSession { get }
    var baseURL: String { get }
}

extension WebRepository {
    func request(apiCall: APICall) async throws -> String {
        let request = try apiCall.urlRequest(baseURL: baseURL)
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw APIError.unexpectedResponse
        }
        
        guard 200..<300 ~= httpResponse.statusCode else {
            throw APIError.httpCode(httpResponse.statusCode)
        }
        
        guard !data.isEmpty else {
            throw APIError.dataEmpty
        }
        
        return String(decoding: data, as: UTF8.self)
        
    }
}
