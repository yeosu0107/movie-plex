//
//  RootViewAppearance.swift
//  
//
//  Created by sungwoo.yeo on 2023/01/09.
//

import SwiftUI

struct RootViewAppearance: ViewModifier {
    @Environment(\.injected) private var injected: DIContainer
    
    func body(content: Content) -> some View {
        content
    }
}
