import Algorithms
import Collections
import Foundation

struct Puzzle202309: Puzzle {
  let input: String

  // MARK: - Public methods

  func solve1() throws -> Any {
    input.lines.map(\.integerValues).map(predictValue).map(\.1).reduce(0, +)
  }

  func solve2() throws -> Any {
    input.lines.map(\.integerValues).map(predictValue).map(\.0).reduce(0, +)
  }

  // MARK: - Private methods

  private func predictValue(of input: [Int]) -> (Int, Int) {
    var sequences = [input]

    while sequences[sequences.count - 1].first(where: { $0 != 0 }) != nil {
      var nextSequence = [Int]()
      var prev: Int?

      for value in sequences.last! {
        if let prev { nextSequence.append(value - prev) }
        prev = value
      }
      sequences.append(nextSequence)
    }
    return (
      sequences.reversed().reduce(0, { $1.first! - $0 }),
      sequences.reversed().reduce(0, { $0 + $1.last! })
    )
  }
}
