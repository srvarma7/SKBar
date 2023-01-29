import XCTest
@testable import SKBar

final class SKBarTests: XCTestCase {
    func testExample() throws {
        XCTAssertEqual(SKBar(frame: .zero, theme: .title).theme, SKBarContentType.title)
    }
}
