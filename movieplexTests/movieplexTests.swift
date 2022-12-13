//
//  movieplexTests.swift
//  movieplexTests
//
//  Created by sungwoo.yeo on 2022/12/13.
//

import XCTest
import Combine
@testable import movieplex

final class movieplexTests: XCTestCase {
    private var movieRepository: MovieRepository!
    private var subscriptions = Set<AnyCancellable>()

    override func setUpWithError() throws {
        movieRepository = MovieRepository(session: URLSession(configuration: .default), baseURL: "")
        subscriptions = Set<AnyCancellable>()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testSearchMovie() throws {
        let exp = XCTestExpectation(description: "Completion")
        let result =  movieRepository.searchMovie()
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
            XCTAssertNotNil(value != "")
        }).store(in: &subscriptions)
        wait(for: [exp], timeout: 2)
    }
    
}
