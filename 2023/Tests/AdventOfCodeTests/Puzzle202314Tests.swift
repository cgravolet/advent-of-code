import XCTest

@testable import AdventOfCode

final class Puzzle202314Tests: XCTestCase {
  let input = """
    O....#....
    O.OO#....#
    .....##...
    OO.#O....O
    .O.....O#.
    O.#..O.#.#
    ..O..#O..O
    .......O..
    #....###..
    #OO..#....
    """

  func testSolve1() throws {
    let sut = Puzzle202314(input: input)
    XCTAssertEqual(try sut.solve1() as? Int, 136)
  }

  func testSolve2() throws {
    let sut = Puzzle202314(input: input)
    XCTAssertEqual(try sut.solve2() as? Int, -1)
  }
}
