//
//  AppEnvironment.swift
//  
//
//  Created by sungwoo.yeo on 2023/01/09.
//

import SwiftUI

struct AppEnvironment {
    let diContainer: DIContainer
}

extension AppEnvironment {
    static func makeAppEnvironment() -> AppEnvironment {
        let movieRepository = DefaultMovieRepository()
        let imageRepository = DefaultImageRepository()
        let containers = configureContainers(movieRepository: movieRepository, imageRepository: imageRepository)
        let diContainer = DIContainer(containers: containers)
        
        return AppEnvironment(diContainer: diContainer)
    }
    
    private static func configureContainers(movieRepository: MovieRepository, imageRepository: ImageRepository) -> DIContainer.InteractorContainers {
        let searchMovieContainer = DefaultSearchMovieContainer(movieRepository: movieRepository)
        let imageContainer = DefaultImageContainer(imageRepository: imageRepository)
        
        return .init(searchMovieContainer: searchMovieContainer, imageContainer: imageContainer)
    }
}
