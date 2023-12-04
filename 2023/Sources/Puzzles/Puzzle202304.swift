import Algorithms
import Collections
import Foundation

struct Puzzle202304: Puzzle {
  let input: [String]

  init(input: String) {
    self.input = input.components(separatedBy: .newlines)
  }

  // MARK: - Public methods

  func solve1() throws -> Any {
    input.compactMap(scratchCards).map(\.score).reduce(0, +)
  }

  func solve2() throws -> Any {
    cardCount(from: input.compactMap(scratchCards).map(\.count))
  }

  // MARK: - Private methods

  /// Counts the total number of cards after considering all the duplicate cards won
  func cardCount(from cards: [Int]) -> Int {
    var scratchcards = cards.map { (winCount: $0, cardCount: 1) }

    for i in 0..<scratchcards.count {
      guard scratchcards[i].winCount > 0 else { continue }

      for _ in 0..<scratchcards[i].cardCount {

        for j in (i + 1)..<(i + 1 + scratchcards[i].winCount) {
          guard scratchcards.count > j else { break }
          scratchcards[j] = (scratchcards[j].winCount, scratchcards[j].cardCount + 1)
        }
      }
    }
    return scratchcards.map(\.cardCount).reduce(0, +)
  }

  /// Returns a scratchcard score and win count from the given
  /// String (i.e. "Card 1: 41 48 83 86 17 | 83 86  6 31 17  9 48 53")
  func scratchCards(from input: String) -> (count: Int, score: Int)? {
    guard
      let numSets = input.split(separator: ": ").last?.split(separator: " | ").map(String.init).map(
        setInt),
      numSets.count == 2
    else { return nil }

    let winCount = numSets[0].intersection(numSets[1]).count
    let score = winCount > 0 ? pow(2, winCount - 1).intValue : 0

    return (winCount, score)
  }

  /// Returns a Set of integers from a String (i.e. "41 48 83 86 17")
  func setInt(from input: String) -> Set<Int> {
    Set(input.matches(of: /(\d+)/).compactMap { Int($0.output.1) })
  }
}
