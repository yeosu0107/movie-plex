import UIKit
import SwiftUI

public struct MovieSearchManager {
    public init() {}
    
    public func launch() -> some View {
        let environment = AppEnvironment.makeAppEnvironment()
        let searchView = SearchView(diContainer: environment.diContainer)
        
        return searchView
    }
}
