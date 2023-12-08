import XCTest

@testable import AdventOfCode

final class Puzzle202308Tests: XCTestCase {

  func testSolve1() throws {
    let input = """
      RL

      AAA = (BBB, CCC)
      BBB = (DDD, EEE)
      CCC = (ZZZ, GGG)
      DDD = (DDD, DDD)
      EEE = (EEE, EEE)
      GGG = (GGG, GGG)
      ZZZ = (ZZZ, ZZZ)
      """
    let sut = Puzzle202308(input: input)
    XCTAssertEqual(try sut.solve1() as? Int, 2)
  }

  func testSolve1_2() throws {
    let input = """
      LLR

      AAA = (BBB, BBB)
      BBB = (AAA, ZZZ)
      ZZZ = (ZZZ, ZZZ)
      """
    let sut = Puzzle202308(input: input)
    XCTAssertEqual(try sut.solve1() as? Int, 6)
  }

  func testSolve2() throws {
    let input = """
      LR

      11A = (11B, XXX)
      11B = (XXX, 11Z)
      11Z = (11B, XXX)
      22A = (22B, XXX)
      22B = (22C, 22C)
      22C = (22Z, 22Z)
      22Z = (22B, 22B)
      XXX = (XXX, XXX)
      """
    let sut = Puzzle202308(input: input)
    XCTAssertEqual(try sut.solve2() as? Int, 6)
  }
}
