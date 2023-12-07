import XCTest

@testable import AdventOfCode

final class Puzzle202307Tests: XCTestCase {
  let input = """
    32T3K 765
    T55J5 684
    KK677 28
    KTJJT 220
    QQQJA 483
    """

  func testSolve1() throws {
    let sut = Puzzle202307(input: input)
    XCTAssertEqual(try sut.solve1() as? Int, 6440)
  }

  func testSolve2() throws {
    let sut = Puzzle202307(input: input)
    XCTAssertEqual(try sut.solve2() as? Int, -1)
  }
}
