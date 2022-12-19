//
//  DependencyInjector.swift
//  movieplex
//
//  Created by sungwoo.yeo on 2022/12/19.
//

import SwiftUI
import Combine

struct DIContainer: EnvironmentKey {
    let appState: AppState
    let interactors: Interactors
    
    init(appState: AppState, interactors: Interactors) {
        self.appState = appState
        self.interactors = interactors
    }
    
    static var defaultValue: Self { Self.default }
    
    private static let `default` = Self(appState: AppState(), interactors: .stub)
}

extension EnvironmentValues {
    var injected: DIContainer {
        get { self[DIContainer.self] }
        set { self[DIContainer.self] = newValue }
    }
}
