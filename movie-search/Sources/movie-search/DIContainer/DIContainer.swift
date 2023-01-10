//
//  DIContainer.swift
//  
//
//  Created by sungwoo.yeo on 2023/01/09.
//

import SwiftUI

struct DIContainer: EnvironmentKey {
    let containers: InteractorContainers
    
    init(containers: InteractorContainers) {
        self.containers = containers
    }
    
    static var defaultValue: Self { Self.default }
    
    private static let `default` = Self(containers: .stub)
}

extension EnvironmentValues {
    var injected: DIContainer {
        get { self[DIContainer.self] }
        set { self[DIContainer.self] = newValue }
    }
}

extension View {
    func inject(_ interactor: DIContainer.InteractorContainers) -> some View {
        let container = DIContainer(containers: interactor)
        
        return inject(container)
    }
    
    func inject(_ container: DIContainer) -> some View {
        return self
            .modifier(RootViewAppearance())
            .environment(\.injected, container)
    }
}

#if DEBUG
extension DIContainer {
    static var preview: Self {
        .init(containers: .stub)
    }
}
#endif
