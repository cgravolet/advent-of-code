import XCTest

@testable import AdventOfCode

final class Puzzle202301Tests: XCTestCase {
  func testSolve1() throws {
    let input = """
      1abc2
      pqr3stu8vwx
      a1b2c3d4e5f
      treb7uchet
      """
    let sut = Puzzle202301(input: input)
    XCTAssertEqual(try sut.solve1() as? Int, 142)
  }

  func testSolve2() throws {
    let input: String = """
      two1nine
      eighthreewo
      abcone2threexyz
      xtwone3four
      4nineeightseven2
      zoneight234
      7pqrstsixteen
      """
    let sut = Puzzle202301(input: input)
    XCTAssertEqual(try sut.solve2() as? Int, 281)
  }
}
