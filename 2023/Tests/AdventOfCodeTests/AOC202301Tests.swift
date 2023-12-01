@testable import AdventOfCode
import XCTest

final class AOCTests: XCTestCase {
    func testAOC202301() throws {
        let input = """
        1abc2
        pqr3stu8vwx
        a1b2c3d4e5f
        treb7uchet
        """
        XCTAssertEqual(try AdventOfCode.AOC202301(input), "142")
    }

    func testAOC202301_part2() throws {
        let input: String = """
        two1nine
        eighthreewo
        abcone2threexyz
        xtwone3four
        4nineeightseven2
        zoneight234
        7pqrstsixteen
        """
        XCTAssertEqual(try AdventOfCode.AOC202301_part2(input), "281")
    }
}
