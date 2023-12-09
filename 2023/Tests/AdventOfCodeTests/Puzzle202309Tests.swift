import XCTest

@testable import AdventOfCode

final class Puzzle202309Tests: XCTestCase {
  let input = """
    0 3 6 9 12 15
    1 3 6 10 15 21
    10 13 16 21 30 45
    """

  func testSolve1() throws {
    let sut = Puzzle202309(input: input)
    XCTAssertEqual(try sut.solve1() as? Int, 114)
  }

  func testSolve2() throws {
    let sut = Puzzle202309(input: input)
    XCTAssertEqual(try sut.solve2() as? Int, 2)
  }
}
