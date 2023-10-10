//
//  NetworkTests.swift
//  NetworkTests
//
//  Created by Anatolii Shumov on 02/10/2023.
//

import XCTest
@testable import MoviesAppUIKit

final class MoviesAppUIKitTests: XCTestCase {
    
    func testFetchImages() async throws {
        let path = "/nKOutYdpjpxdeftoXcDnSAaD2z8.jpg"
        let image = try await Network.Client.shared.fetchImage(with: path)
        XCTAssertNotNil(image)
        XCTAssertNoThrow(image)
    }
    
    func testFetchData() async throws {
        Network.Client.shared.get(.photos(id: 157336)) { (result: Result<Network.Types.Response.Backdrops, Network.Errors>) in
            switch result {
            case .success(let success):
                XCTAssertNotNil(success)
                XCTAssertTrue(success.backdrops.count > 1)
            case .failure(let failure):
                XCTAssertThrowsError(failure)
            }
        }
        
        Network.Client.shared.get(.movie(id: 157336)) { (result: Result<Network.Types.Response.MovieObject, Network.Errors>) in
            switch result {
            case .success(let success):
                XCTAssertNotNil(success)
                XCTAssertEqual(success.id, 157336)
            case .failure(let failure):
                XCTAssertThrowsError(failure)
            }
        }
        
        Network.Client.shared.get(.videos(id: 157336)) { (result: Result<Network.Types.Response.VideoResults, Network.Errors>) in
            switch result {
            case .success(let success):
                XCTAssertNotNil(success)
                XCTAssertTrue(success.results.count > 0)
            case .failure(let failure):
                XCTAssertThrowsError(failure)
            }
        }
        
        Network.Client.shared.get(.nowPlaying(page: 2)) { (result: Result<Network.Types.Response.MovieResults, Network.Errors>) in
            switch result {
            case .success(let success):
                XCTAssertNotNil(success)
                XCTAssertTrue(success.results.count > 1)
            case .failure(let failure):
                XCTAssertThrowsError(failure)
            }
        }
        
        Network.Client.shared.get(.topRated(page: 2)) { (result: Result<Network.Types.Response.MovieResults, Network.Errors>) in
            switch result {
            case .success(let success):
                XCTAssertNotNil(success)
                XCTAssertTrue(success.results.count > 1)
            case .failure(let failure):
                XCTAssertThrowsError(failure)
            }
        }
        
        Network.Client.shared.get(.popular(page: 2)) { (result: Result<Network.Types.Response.MovieResults, Network.Errors>) in
            switch result {
            case .success(let success):
                XCTAssertNotNil(success)
                XCTAssertTrue(success.results.count > 1)
            case .failure(let failure):
                XCTAssertThrowsError(failure)
            }
        }
    }
}
