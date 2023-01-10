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
        let containers = configureContainers(movieRepository: movieRepository)
        let diContainer = DIContainer(containers: containers)
        
        return AppEnvironment(diContainer: diContainer)
    }
    
    private static func configureContainers(movieRepository: MovieRepository) -> DIContainer.InteractorContainers {
        let searchMovieContainer = DefaultSearchMovieContainer(movieRepository: movieRepository)
        
        return .init(searchMovieContainer: searchMovieContainer)
    }
}
