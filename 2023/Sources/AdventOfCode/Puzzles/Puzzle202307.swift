import Algorithms
import Collections
import Foundation

struct Puzzle202307: Puzzle {
  let input: String

  // MARK: - Public methods

  func solve1() throws -> Any {
    solve(input, isJokers: false)
  }

  func solve2() throws -> Any {
    solve(input, isJokers: true)
  }

  // MARK: - Private methods

  /// Parses a CamelCardHand from the given String (e.g. "32T3K 765").
  func card(from input: String, isJokers: Bool = false) -> CamelCardHand? {
    let components = input.components(separatedBy: " ")
    guard components.count == 2 else { return nil }
    return CamelCardHand(rawValue: components[0], bid: Int(components[1]) ?? 0, isJokers: isJokers)
  }

  private func solve(_ input: String, isJokers: Bool) -> Int {
    input.lines
      .compactMap { card(from: $0, isJokers: isJokers) }
      .sorted(by: <)
      .enumerated()
      .map { ($0 + 1) * $1.bid }
      .reduce(0, +)
  }
}
