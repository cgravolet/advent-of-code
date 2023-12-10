import XCTest

@testable import AdventOfCode

final class Puzzle202310Tests: XCTestCase {
  func testCoordAddition() throws {
    let start = Coord2D(x: 5, y: 5)
    XCTAssertEqual(start + Coord2D(x: 0, y: 0), Coord2D(x: 5, y: 5))
    XCTAssertEqual(start + Coord2D(x: 1, y: 0), Coord2D(x: 6, y: 5))
    XCTAssertEqual(start + Coord2D(x: 0, y: 1), Coord2D(x: 5, y: 6))
    XCTAssertEqual(start + Coord2D(x: -1, y: 0), Coord2D(x: 4, y: 5))
    XCTAssertEqual(start + Coord2D(x: 0, y: -1), Coord2D(x: 5, y: 4))
  }

  func testSolve1() throws {
    let input = """
      -L|F7
      7S-7|
      L|7||
      -L-J|
      L|-JF
      """
    let sut = Puzzle202310(input: input)
    XCTAssertEqual(try sut.solve1() as? Int, 4)
  }

  func testSolve1_2() throws {
    let input = """
      7-F7-
      .FJ|7
      SJLL7
      |F--J
      LJ.LJ
      """
    let sut = Puzzle202310(input: input)
    XCTAssertEqual(try sut.solve1() as? Int, 8)
  }

  func testSolve2() throws {
    let input = """
      """
    let sut = Puzzle202310(input: input)
    XCTAssertEqual(try sut.solve2() as? Int, -1)
  }
}
