@testable import AdventOfCode
import XCTest

final class Puzzle202303Tests: XCTestCase {
  func testSolve1() throws {
    let input = """
    """
    let sut = Puzzle202303(input: input)
    XCTAssertEqual(try sut.solve1() as? Int, -1)
  }

  func testSolve2() throws {
    let input: String = """
    """
    let sut = Puzzle202303(input: input)
    XCTAssertEqual(try sut.solve2() as? Int, -1)
  }
}
