import XCTest

@testable import AdventOfCode

final class Puzzle202311Tests: XCTestCase {
  let input = """
    ...#......
    .......#..
    #.........
    ..........
    ......#...
    .#........
    .........#
    ..........
    .......#..
    #...#.....
    """

  func testSolve1() throws {
    let sut = Puzzle202311(input: input)
    XCTAssertEqual(try sut.solve1() as? Int, 374)
  }

  func testSolve2() throws {
    let sut = Puzzle202311(input: input)
    XCTAssertEqual(try sut.solve2() as? Int, 82_000_210)
  }
}
