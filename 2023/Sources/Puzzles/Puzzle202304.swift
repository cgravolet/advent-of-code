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

  func cardCount(from cards: [Int]) -> Int {
    var scratchcards = cards.map { (score: $0, count: 1) }

    for i in 0..<scratchcards.count {
      guard scratchcards[i].score > 0 else { continue }
      for _ in 0..<scratchcards[i].count {
        for j in (i+1)..<(i+1+scratchcards[i].score) {
          guard scratchcards.count > j else { continue }
          scratchcards[j] = (scratchcards[j].score, scratchcards[j].count + 1)
        }
      }
    }
    return scratchcards.map(\.count).reduce(0, +)
  }

  /// Returns a scratchcard score and win count from the given
  /// String (i.e. "Card 1: 41 48 83 86 17 | 83 86  6 31 17  9 48 53")
  func scratchCards(from input: String) -> (count: Int, score: Int)? {
    let components = input.split(separator: ": ")

    guard let numSets = components.last?.split(separator: " | ").map(String.init).map(setInt),
      numSets.count == 2
    else { return nil }

    let winCount = numSets[0].intersection(numSets[1]).count
    let score = winCount > 0 ? Int(UInt(1 << (winCount - 1))) : 0

    return (winCount, score)
  }

  /// Returns a Set of integers from a String (i.e. "41 48 83 86 17")
  func setInt(from input: String) -> Set<Int> {
    Set(input.matches(of: /(\d+)/).compactMap { Int($0.output.1) })
  }
}
