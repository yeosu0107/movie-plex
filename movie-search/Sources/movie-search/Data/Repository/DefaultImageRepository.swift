//
//  DefaultImageRepository.swift
//  
//
//  Created by sungwoo.yeo on 2023/01/10.
//

import Foundation
import UIKit

final class DefaultImageRepository: ImageRepository {
    func loadImage(url: String) async throws -> UIImage {
        guard let url = URL(string: url) else {
            throw APIError.invalidURL
        }
        
        let urlRequest = URLRequest(url: url)
        let data = try await request(request: urlRequest)
        guard let uiImage: UIImage = UIImage(data: data) else {
            throw APIError.parseError
        }
        
        return uiImage
    }
}
