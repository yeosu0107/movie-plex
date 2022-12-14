//
//  LoadableObject.swift
//  movieplex
//
//  Created by sungwoo.yeo on 2022/12/14.
//

import Foundation
import SwiftUI

typealias LoadableObject<Value> = Binding<Loadable<Value>>

enum Loadable<T> {
    case notRequested
    case isLoading(cancelBag: CancelBag)
    case loaded(T)
    case failed(Error)
    
    var value: T? {
        switch self {
        case let .loaded(value):
            return value
        default:
            return nil
        }
    }
    
    var error: Error? {
        switch self {
        case let .failed(error):
            return error
        default:
            return nil
        }
    }
}

extension Loadable {
    mutating func setIsLoading(cancelBag: CancelBag) {
        self = .isLoading(cancelBag: cancelBag)
    }
    
    mutating func cancelLoading() {
        switch self {
        case let .isLoading(cancelBag):
            cancelBag.cancel()
            let error = NSError(domain: NSCocoaErrorDomain, code: NSUserCancelledError)
            self = .failed(error)
        default:
            break
        }
    }
    
    mutating func setFail(error: Error) {
        self = .failed(error)
    }
}

extension Loadable: Equatable where T: Equatable {
    static func == (lhs: Loadable<T>, rhs: Loadable<T>) -> Bool {
        switch (lhs, rhs) {
        case (.notRequested, .notRequested):
            return true
        case (.isLoading(_), .isLoading(_)):
            return true
        case let (.failed(lhsE), .failed(rhsE)):
            return lhsE.localizedDescription == rhsE.localizedDescription
        case let (.loaded(lhsV), .loaded(rhsV)):
            return lhsV == rhsV
        default:
            return false
        }
    }
}
