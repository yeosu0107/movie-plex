//
//  movieplexApp.swift
//  movieplex
//
//  Created by sungwoo.yeo on 2022/12/12.
//

import SwiftUI

@main
struct MoviePlexApp: App {
    private var injected: DIContainer
    
    init() {
        let movieInteractor = MovieInteractorImpl(movieRepository: MovieRepository())
        
        self.injected = DIContainer(
            appState: AppState(),
            interactors: DIContainer.Interactors(movieInteractor: movieInteractor))
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.injected, injected)
            
        }
    }
}
