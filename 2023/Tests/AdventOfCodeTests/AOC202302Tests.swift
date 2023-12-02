@testable import AdventOfCode
import XCTest

final class AOC202302Tests: XCTestCase {
    func testPart1() throws {
        let input = """
        Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green
        Game 2: 1 blue, 2 green; 3 green, 4 blue, 1 red; 1 green, 1 blue
        Game 3: 8 green, 6 blue, 20 red; 5 blue, 4 red, 13 green; 5 green, 1 red
        Game 4: 1 green, 3 red, 6 blue; 3 green, 6 red; 3 green, 15 blue, 14 red
        Game 5: 6 red, 1 blue, 3 green; 2 blue, 1 red, 2 green
        """
        XCTAssertEqual(try AdventOfCode.AOC202302(input).0, "8")
    }

    func testPart2() throws {
        let input: String = """
        """
        XCTAssertEqual(try AdventOfCode.AOC202302(input).1, "TODO")
    }
}
