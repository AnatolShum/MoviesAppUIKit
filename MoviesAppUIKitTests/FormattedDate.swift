//
//  FormattedDate.swift
//  MoviesAppUIKitTests
//
//  Created by Anatolii Shumov on 10/10/2023.
//

import XCTest
@testable import MoviesAppUIKit

final class FormattedDate: XCTestCase {
    var movieCell: MovieCell!
    var movie: Movie!
    
    override func setUpWithError() throws {
        movieCell = MovieCell()
        movie = Movie(
        title: "John Wick: Chapter 4",
        id: 603692,
        backdrop: "/7I6VUdPj6tQECNHdviJkUHD2u89.jpg",
        poster: "/vZloFAK7NmvMGKE7VkF5UHaz0I.jpg",
        releaseDate: "2023-03-22",
        overview: "With the price on his head ever increasing, ...",
        vote: 7.8)
    }

    override func tearDownWithError() throws {
        movieCell = nil
    }

    func testFormattedDate() throws {
        let formattedDate = movieCell.formattedDate(movie.releaseDate)
        XCTAssertFalse(formattedDate.isEmpty)
        XCTAssertEqual(formattedDate, "22 Mar 2023")
    }

}
