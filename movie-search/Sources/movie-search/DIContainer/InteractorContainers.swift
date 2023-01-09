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
        
        init(searchMovieContainer: SearchMovieContainer) {
            self.searchMovieContainer = searchMovieContainer
        }
        
        static var stub: Self {
            .init(searchMovieContainer: StubSearchMovieContainer())
        }
    }
}

