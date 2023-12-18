import XCTest

@testable import AdventOfCode

final class Puzzle202317Tests: XCTestCase {
  let input = """
    2413432311323
    3215453535623
    3255245654254
    3446585845452
    4546657867536
    1438598798454
    4457876987766
    3637877979653
    4654967986887
    4564679986453
    1224686865563
    2546548887735
    4322674655533
    """

  func testSolve1() throws {
    let sut = Puzzle202317(input: input)
    XCTAssertEqual(try sut.solve1() as? Int, 102)
  }

  func testSolve2() throws {
    let sut = Puzzle202317(input: input)
    XCTAssertEqual(try sut.solve2() as? Int, -1)
  }
}
