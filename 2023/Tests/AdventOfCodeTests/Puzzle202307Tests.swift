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
    XCTAssertEqual(try sut.solve2() as? Int, 5905)
  }

  func testCamelCards() throws {
    let tests: [(given: String, expected: CamelCardHandStrength)] = [
      ("2345A 1", .highCard),
      ("Q2KJJ 13", .onePair),
      ("Q2Q2Q 19", .fullHouse),
      ("T3T3J 17", .twoPair),
      ("T3Q33 11", .threeOfAKind),
      ("2345J 3", .highCard),
      ("J345A 2", .highCard),
      ("32T3K 5", .onePair),
      ("T55J5 29", .threeOfAKind),
      ("KK677 7", .twoPair),
      ("KTJJT 34", .twoPair),
      ("QQQJA 31", .threeOfAKind),
      ("JJJJJ 37", .fiveOfAKind),
      ("JAAAA 43", .fourOfAKind),
      ("AAAAJ 59", .fourOfAKind),
      ("AAAAA 61", .fiveOfAKind),
      ("2AAAA 23", .fourOfAKind),
      ("2JJJJ 53", .fourOfAKind),
      ("JJJJ2 41", .fourOfAKind),
    ]
    let sut = Puzzle202307(input: input)

    for test in tests {
      guard let hand = sut.card(from: test.given, isJokers: false) else {
        XCTFail("Could not parse hand from input \(test.given)")
        continue
      }
      XCTAssertEqual(hand.strength, test.expected, "Given: \"\(test.given)\"")
    }
  }

  func testCamelCardsWithJokers() throws {
    let tests: [(given: String, expected: CamelCardHandStrength)] = [
      ("2345A 1", .highCard),
      ("Q2KJJ 13", .threeOfAKind),
      ("Q2Q2Q 19", .fullHouse),
      ("T3T3J 17", .fullHouse),
      ("T3Q33 11", .threeOfAKind),
      ("2345J 3", .onePair),
      ("J345A 2", .onePair),
      ("32T3K 5", .onePair),
      ("T55J5 29", .fourOfAKind),
      ("KK677 7", .twoPair),
      ("KTJJT 34", .fourOfAKind),
      ("QQQJA 31", .fourOfAKind),
      ("JJJJJ 37", .fiveOfAKind),
      ("JAAAA 43", .fiveOfAKind),
      ("AAAAJ 59", .fiveOfAKind),
      ("AAAAA 61", .fiveOfAKind),
      ("2AAAA 23", .fourOfAKind),
      ("2JJJJ 53", .fiveOfAKind),
      ("JJJJ2 41", .fiveOfAKind),
    ]
    let sut = Puzzle202307(input: input)

    for test in tests {
      guard let hand = sut.card(from: test.given, isJokers: true) else {
        XCTFail("Could not parse hand from input \(test.given)")
        continue
      }
      XCTAssertEqual(hand.strength, test.expected, "Given: \"\(test.given)\"")
    }
  }
}
