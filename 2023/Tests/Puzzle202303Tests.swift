import XCTest

@testable import AdventOfCode

final class Puzzle202303Tests: XCTestCase {
  func testSolve1() throws {
    let input = """
      467..114..
      ...*......
      ..35..633.
      ......#...
      617*......
      .....+.58.
      ..592.....
      ......755.
      ...$.*....
      .664.598..
      """
    let sut = Puzzle202303(input: input)
    XCTAssertEqual(try sut.solve1() as? Int, 4361)
  }

  func testSolve2() throws {
    let input = """
      467..114..
      ...*......
      ..35..633.
      ......#...
      617*......
      .....+.58.
      ..592.....
      ......755.
      ...$.*....
      .664.598..
      """
    let sut = Puzzle202303(input: input)
    XCTAssertEqual(try sut.solve2() as? Int, 467835)
  }
}
