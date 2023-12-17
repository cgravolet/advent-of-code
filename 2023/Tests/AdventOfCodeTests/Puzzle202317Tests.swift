import XCTest

@testable import AdventOfCode

final class Puzzle202317Tests: XCTestCase {
  let input = """
    """

  func testSolve1() throws {
    let sut = Puzzle202317(input: input)
    XCTAssertEqual(try sut.solve1() as? Int, -1)
  }

  func testSolve2() throws {
    let sut = Puzzle202317(input: input)
    XCTAssertEqual(try sut.solve2() as? Int, -1)
  }
}