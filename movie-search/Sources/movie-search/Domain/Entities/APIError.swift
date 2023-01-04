//
//  APIError.swift
//  
//
//  Created by sungwoo.yeo on 2023/01/04.
//

import Foundation

enum APIError: Swift.Error {
    case invalidURL
    case httpCode(HTTPCode)
    case unexpectedResponse
    case dataEmpty
    case parseError
}

extension APIError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .invalidURL: return "Invalid URL"
        case let .httpCode(code): return "Http error: \(code)"
        case .unexpectedResponse: return "Unexpected response"
        case .dataEmpty: return "Data is empty"
        case .parseError: return "Fail to parse data"
        }
    }
}


typealias HTTPCode = Int
typealias HTTPCodes = Range<HTTPCode>

extension HTTPCodes {
    static let success = 200 ..< 300
}
