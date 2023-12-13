import XCTest

@testable import AdventOfCode

final class Puzzle202312Tests: XCTestCase {
  let input = """
    ???.### 1,1,3
    .??..??...?##. 1,1,3
    ?#?#?#?#?#?#?#? 1,3,1,6
    ????.#...#... 4,1,1
    ????.######..#####. 1,6,5
    ?###???????? 3,2,1
    """

  func testSolve1() throws {
    let sut = Puzzle202312(input: input)
    XCTAssertEqual(try sut.solve1() as? Int, 21)
  }

  func testSolve2() throws {
    let sut = Puzzle202312(input: input)
    XCTAssertEqual(try sut.solve2() as? Int, 525152)
  }
}
