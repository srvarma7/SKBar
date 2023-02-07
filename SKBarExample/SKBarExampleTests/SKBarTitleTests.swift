//
//  SKBarTitleTests.swift
//  SKBarTitleTests
//
//  Created by Sai Kallepalli on 05/02/23.
//

import XCTest
@testable import SKBar

final class SKBarTitleTests: XCTestCase {
    
    var sut: SKBar!

    override func setUpWithError() throws {
        sut = SKBar(frame: .zero, theme: .title)
    }
    
    override func tearDownWithError() throws {
        sut = nil
    }

    func testBarThemeShouldBeTitleWhenInitialized() throws {
        XCTAssertTrue(sut.theme == .title)
    }
    
    func testBarThemeShouldBeImageAndTitleWhenInitialized() throws {
        sut.theme = .imageAndTitle
        XCTAssertTrue(sut.theme == .imageAndTitle)
    }
}
