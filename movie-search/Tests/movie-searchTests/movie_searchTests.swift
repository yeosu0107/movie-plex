import XCTest
@testable import movie_search

final class movie_searchTests: XCTestCase {
    private var movieRepository: MovieRepository!
    
    override func setUpWithError() throws {
        movieRepository = DefaultMovieRepository()
    }
    
    func testSearchMovie() async throws {
        let result = try await movieRepository.searchMovie(keyword: "커피")
        print(result)
    }
}
