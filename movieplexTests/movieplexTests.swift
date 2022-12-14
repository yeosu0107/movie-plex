//
//  movieplexTests.swift
//  movieplexTests
//
//  Created by sungwoo.yeo on 2022/12/13.
//

import XCTest
import Combine
import SwiftUI
@testable import movieplex

final class movieplexTests: XCTestCase {
    private var movieRepository: MovieRepository!
    private var movieInteractor: MovieInteractor!
    private var subscriptions = Set<AnyCancellable>()

    override func setUpWithError() throws {
        movieRepository = MovieRepository()
        movieInteractor = MovieInteractorImpl(movieRepository: movieRepository)
        subscriptions = Set<AnyCancellable>()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testSearchMovieRepository() throws {
        let exp = XCTestExpectation(description: "Completion")
        let result =  movieRepository.searchMovie(keyword: "plex")
        result.sink(receiveCompletion: { completion in
            switch completion {
            case let .failure(error):
                print("###### search movie error: \(error) ######")
                XCTFail("\(error)")
            default:
                break
            }
        }, receiveValue: { value in
            print("###### search movie result: \(value) ######")
            exp.fulfill()
        }).store(in: &subscriptions)
        wait(for: [exp], timeout: 2)

    }
    
    func testSearchMovieInteractor() throws {
        let exp = XCTestExpectation(description: "Completion")
        let movieList = BindingWithPublisher(value: Loadable<Channel>.notRequested)
    
        movieInteractor.search(keyword: "plex", movieList: movieList.binding)
        movieList.updatesRecorder.sink { updates in
            XCTAssertNotNil(updates.last?.value)
            print("###### search movie result: \(String(describing: updates.last?.value)) ######")
            exp.fulfill()
        }.store(in: &subscriptions)
        wait(for: [exp], timeout: 2)
    }
    
}

struct BindingWithPublisher<Value> {
    
    let binding: Binding<Value>
    let updatesRecorder: AnyPublisher<[Value], Never>
    
    init(value: Value, recordingTimeInterval: TimeInterval = 0.5) {
        var value = value
        var updates = [value]
        binding = Binding<Value>(
            get: { value },
            set: { value = $0; updates.append($0) })
        updatesRecorder = Future<[Value], Never> { completion in
            DispatchQueue.main.asyncAfter(deadline: .now() + recordingTimeInterval) {
                completion(.success(updates))
            }
        }.eraseToAnyPublisher()
    }
}
