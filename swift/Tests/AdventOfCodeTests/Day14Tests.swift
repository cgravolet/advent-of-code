@testable import AdventOfCode
import XCTest

final class Day14Tests: XCTestCase {
    private var sampleInput = """
    498,4 -> 498,6 -> 496,6
    503,4 -> 502,4 -> 502,9 -> 494,9
    """

    func testPart1() throws {
        let sut = Day14()
        let want = 24
        let got = sut.part1(input: sampleInput)
        XCTAssertEqual(got, want)
    }
}