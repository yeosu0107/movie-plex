//
//  WebRepository.swift
//  movieplex
//
//  Created by sungwoo.yeo on 2022/12/12.
//

import Foundation
import Combine

protocol WebRepository {
    var session: URLSession { get }
    var baseURL: String { get }
    var bgQueue: DispatchQueue { get }
}

extension WebRepository {
    func request(endpoint: APICall) -> AnyPublisher<String, Error> {
        do {
            let request = try endpoint.urlRequest(baseURL: baseURL)
            return session
                .dataTaskPublisher(for: request)
                .tryMap() { data, response in
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
                .mapError {error in
                    if let error = error as? APIError {
                        return error
                    } else {
                        return APIError.parseError
                    }
                }
                .eraseToAnyPublisher()
        } catch let error {
            return Fail<String, Error>(error: error).eraseToAnyPublisher()
        }
    }
}
