//
//  ImageContainer.swift
//  
//
//  Created by sungwoo.yeo on 2023/01/10.
//

import Foundation
import UIKit

protocol ImageContainer {
    func load(url: String) async throws -> UIImage
}

final class DefaultImageContainer: ImageContainer {
    let imageRepository: ImageRepository
    
    init(imageRepository: ImageRepository) {
        self.imageRepository = imageRepository
    }
    
    func load(url: String) async throws -> UIImage {
        return try await imageRepository.loadImage(url: url)
    }
}

final class StubImageContainer: ImageContainer {
    func load(url: String) async throws -> UIImage {
        let stubChannelTask = Task { () -> UIImage in
            return emptyImage()
        }
        return try await stubChannelTask.result.get()
    }
    
    func emptyImage() -> UIImage {
        UIGraphicsBeginImageContext(CGSize(width: 10, height: 10))
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
}
