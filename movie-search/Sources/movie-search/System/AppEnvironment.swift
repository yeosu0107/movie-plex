//
//  AppEnvironment.swift
//  
//
//  Created by sungwoo.yeo on 2023/01/09.
//

import SwiftUI

struct AppEnvironment {
    let container: DIContainer
}

extension AppEnvironment {
    static func makeAppEnvironment() -> AppEnvironment {
        let movieRepository = DefaultMovieRepository()
        let containers = configureContainers(movieRepository: movieRepository)
        let diContainer = DIContainer(container: containers)
        
        return AppEnvironment(container: diContainer)
    }
    
    private static func configureContainers(movieRepository: MovieRepository) -> DIContainer.InteractorContainers {
        let searchMovieContainer = DefaultSearchMovieContainer(movieRepository: movieRepository)
        
        return .init(searchMovieContainer: searchMovieContainer)
    }
}
