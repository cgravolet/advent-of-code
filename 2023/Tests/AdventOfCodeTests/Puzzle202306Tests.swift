import XCTest

@testable import AdventOfCode

final class Puzzle202306Tests: XCTestCase {
  let input = """
    Time:      7  15   30
    Distance:  9  40  200
    """

  func testSolve1() throws {
    let sut = Puzzle202306(input: input)
    XCTAssertEqual(try sut.solve1() as? Int, 288)
  }

  func testSolve2() throws {
    let sut = Puzzle202306(input: input)
    XCTAssertEqual(try sut.solve2() as? Int, 71503)
  }
}
