@testable import AdventOfCode
import XCTest

final class AOCTests: XCTestCase {
    func testAOC202301() throws {
        let input = "THIS IS A TEST"
        XCTAssertEqual(try AdventOfCode.AOC202301(input), "14")
    }
}
