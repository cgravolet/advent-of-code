import XCTest

@testable import AdventOfCode

final class Puzzle202305Tests: XCTestCase {
  func testSolve1() throws {
    let input = """
      seeds: 79 14 55 13

      seed-to-soil map:
      50 98 2
      52 50 48

      soil-to-fertilizer map:
      0 15 37
      37 52 2
      39 0 15

      fertilizer-to-water map:
      49 53 8
      0 11 42
      42 0 7
      57 7 4

      water-to-light map:
      88 18 7
      18 25 70

      light-to-temperature map:
      45 77 23
      81 45 19
      68 64 13

      temperature-to-humidity map:
      0 69 1
      1 0 69

      humidity-to-location map:
      60 56 37
      56 93 4
      """
    let sut = Puzzle202305(input: input)
    XCTAssertEqual(try sut.solve1() as? Int, 35)
  }

  func testSolve2() throws {
    let input: String = """
      """
    let sut = Puzzle202305(input: input)
    XCTAssertEqual(try sut.solve2() as? Int, -1)
  }
}
