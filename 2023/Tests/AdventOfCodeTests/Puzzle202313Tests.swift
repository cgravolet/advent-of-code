import XCTest

@testable import AdventOfCode

final class Puzzle202313Tests: XCTestCase {
  let input = """
    #.##..##.
    ..#.##.#.
    ##......#
    ##......#
    ..#.##.#.
    ..##..##.
    #.#.##.#.

    #...##..#
    #....#..#
    ..##..###
    #####.##.
    #####.##.
    ..##..###
    #....#..#
    """

  func testSolve1() throws {
    let sut = Puzzle202313(input: input)
    XCTAssertEqual(try sut.solve1() as? Int, 405)
  }

  func testSolve2() throws {
    let sut = Puzzle202313(input: input)
    XCTAssertEqual(try sut.solve2() as? Int, 400)
  }
}
