//
//  Repository.swift
//  
//
//  Created by sungwoo.yeo on 2023/01/04.
//

import Foundation
import Combine

protocol WebRepository {
    
}

extension WebRepository {
    func request(request: URLRequest) async throws -> Data {
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
        
        return data
    }
}
