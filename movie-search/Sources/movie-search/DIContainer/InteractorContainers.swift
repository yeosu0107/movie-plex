//
//  InteractorContainers.swift
//  
//
//  Created by sungwoo.yeo on 2023/01/09.
//

import SwiftUI

extension DIContainer {
    struct InteractorContainers {
        let searchMovieContainer: SearchMovieContainer
        let imageContainer: ImageContainer

        init(searchMovieContainer: SearchMovieContainer, imageContainer: ImageContainer) {
            self.searchMovieContainer = searchMovieContainer
            self.imageContainer = imageContainer
        }
        
        static var stub: Self {
            .init(searchMovieContainer: StubSearchMovieContainer(), imageContainer: StubImageContainer())
        }
    }
}

