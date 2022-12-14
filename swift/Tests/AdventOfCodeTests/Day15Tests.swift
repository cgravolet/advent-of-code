@testable import AdventOfCode
import XCTest

final class Day15Tests: XCTestCase {
    private var sampleInput = """
    """

    func testPart1() throws {
        let sut = Day15()
        let want = 0
        let got = sut.part1(sampleInput)
        XCTAssertEqual(got, want)
    }

    func testPart2() throws {
        let sut = Day15()
        let want = 0
        let got = sut.part2(sampleInput)
        XCTAssertEqual(got, want)
    }
}