//
//  CircleVote.swift
//  MoviesAppUIKitTests
//
//  Created by Anatolii Shumov on 10/10/2023.
//

import XCTest
@testable import MoviesAppUIKit

final class CircleVote: XCTestCase {
    var circularProgressView: CircularProgressView!

    override func setUpWithError() throws {
        circularProgressView = CircularProgressView()
    }

    override func tearDownWithError() throws {
        circularProgressView = nil
    }

    func testColor() throws {
        for vote in 0...10 {
           let color = circularProgressView.setColor(with: Double(vote))
            XCTAssertNotEqual(color, .gray)
        }
    
        let purple = circularProgressView.setColor(with: 2.999)
        XCTAssertEqual(purple, .systemPurple.withAlphaComponent(0.7))
        
        let red = circularProgressView.setColor(with: 3.1)
        XCTAssertEqual(red, .systemRed.withAlphaComponent(0.7))
        
        let orange = circularProgressView.setColor(with: 5.99)
        XCTAssertEqual(orange, .systemOrange.withAlphaComponent(0.7))
        
        let yellow = circularProgressView.setColor(with: 6.5)
        XCTAssertEqual(yellow, .systemYellow.withAlphaComponent(0.7))
        
        let green = circularProgressView.setColor(with: 7.1)
        XCTAssertEqual(green, .systemGreen.withAlphaComponent(0.7))
    }

}
