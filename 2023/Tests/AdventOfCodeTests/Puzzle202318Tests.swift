import XCTest

@testable import AdventOfCode

final class Puzzle202318Tests: XCTestCase {
  let input = """
    R 6 (#70c710)
    D 5 (#0dc571)
    L 2 (#5713f0)
    D 2 (#d2c081)
    R 2 (#59c680)
    D 2 (#411b91)
    L 5 (#8ceee2)
    U 2 (#caa173)
    L 1 (#1b58a2)
    U 2 (#caa171)
    R 2 (#7807d2)
    U 3 (#a77fa3)
    L 2 (#015232)
    U 2 (#7a21e3)
    """

  func testSolve1() throws {
    let sut = Puzzle202318(input: input)
    XCTAssertEqual(try sut.solve1() as? Int, 62)
  }

  func testSolve2() throws {
    let sut = Puzzle202318(input: input)
    XCTAssertEqual(try sut.solve2() as? Int, 952_408_144_115)
  }
}
