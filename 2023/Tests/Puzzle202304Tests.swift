import XCTest

@testable import AdventOfCode

final class Puzzle202304Tests: XCTestCase {
  func testSolve1() throws {
    let input = """
      """
    let sut = Puzzle202304(input: input)
    XCTAssertEqual(try sut.solve1() as? Int, -1)
  }

  func testSolve2() throws {
    let input: String = """
      """
    let sut = Puzzle202304(input: input)
    XCTAssertEqual(try sut.solve2() as? Int, -1)
  }
}
