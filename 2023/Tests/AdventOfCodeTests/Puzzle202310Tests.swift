import XCTest

@testable import AdventOfCode

final class Puzzle202310Tests: XCTestCase {
  func testCoordAddition() throws {
    let start = Coord2D(5, 5)
    XCTAssertEqual(start + Coord2D(0, 0), Coord2D(5, 5))
    XCTAssertEqual(start + Coord2D(1, 0), Coord2D(6, 5))
    XCTAssertEqual(start + Coord2D(0, 1), Coord2D(5, 6))
    XCTAssertEqual(start + Coord2D(-1, 0), Coord2D(4, 5))
    XCTAssertEqual(start + Coord2D(0, -1), Coord2D(5, 4))
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
      ...........
      .S-------7.
      .|F-----7|.
      .||.....||.
      .||.....||.
      .|L-7.F-J|.
      .|..|.|..|.
      .L--J.L--J.
      ...........
      """
    let sut = Puzzle202310(input: input)
    XCTAssertEqual(try sut.solve2() as? Int, 4)
  }

  func testSolve2_2() throws {
    let input = """
      .F----7F7F7F7F-7....
      .|F--7||||||||FJ....
      .||.FJ||||||||L7....
      FJL7L7LJLJ||LJ.L-7..
      L--J.L7...LJS7F-7L7.
      ....F-J..F7FJ|L7L7L7
      ....L7.F7||L7|.L7L7|
      .....|FJLJ|FJ|F7|.LJ
      ....FJL-7.||.||||...
      ....L---J.LJ.LJLJ...
      """
    let sut = Puzzle202310(input: input)
    XCTAssertEqual(try sut.solve2() as? Int, 8)
  }

  func testSolve2_3() throws {
    let input = """
      FF7FSF7F7F7F7F7F---7
      L|LJ||||||||||||F--J
      FL-7LJLJ||||||LJL-77
      F--JF--7||LJLJ7F7FJ-
      L---JF-JLJ.||-FJLJJ7
      |F|F-JF---7F7-L7L|7|
      |FFJF7L7F-JF7|JL---7
      7-L-JL7||F7|L7F-7F7|
      L.L7LFJ|||||FJL7||LJ
      L7JLJL-JLJLJL--JLJ.L
      """
    let sut = Puzzle202310(input: input)
    XCTAssertEqual(try sut.solve2() as? Int, 10)
  }
}
