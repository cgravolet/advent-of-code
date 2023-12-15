import XCTest

@testable import AdventOfCode

final class Puzzle202315Tests: XCTestCase {
  let input = "rn=1,cm-,qp=3,cm=2,qp-,pc=4,ot=9,ab=5,pc-,pc=6,ot=7"

  func testSolve1() throws {
    let sut = Puzzle202315(input: input)
    XCTAssertEqual(try sut.solve1() as? Int, 1320)
  }

  func testSolve2() throws {
    let sut = Puzzle202315(input: input)
    XCTAssertEqual(try sut.solve2() as? Int, -1)
  }
}
