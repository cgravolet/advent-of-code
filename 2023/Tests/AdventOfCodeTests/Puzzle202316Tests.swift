import XCTest

@testable import AdventOfCode

final class Puzzle202316Tests: XCTestCase {
  let input = """
    .|...\\....
    |.-.\\.....
    .....|-...
    ........|.
    ..........
    .........\\
    ..../.\\\\..
    .-.-/..|..
    .|....-|.\\
    ..//.|....
    """

  func testSolve1() throws {
    let sut = Puzzle202316(input: input)
    XCTAssertEqual(try sut.solve1() as? Int, 46)
  }

  func testSolve2() throws {
    let sut = Puzzle202316(input: input)
    XCTAssertEqual(try sut.solve2() as? Int, 51)
  }
}
