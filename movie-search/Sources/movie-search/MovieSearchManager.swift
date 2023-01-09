import UIKit
import SwiftUI

public struct MovieSearchManager {
    public init() {}
    
    public func launch() -> some View {
        let environment = AppEnvironment.makeAppEnvironment()
        let searchView = SearchView(container: environment.container)
        
        return searchView
    }
}
