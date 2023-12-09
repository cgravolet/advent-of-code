import Algorithms
import Collections
import Foundation

struct Puzzle202309: Puzzle {
  let input: String

  // MARK: - Public methods

  func solve1() throws -> Any {
    try input.lines.map(\.integerValues).map(predictValue).map(\.next).reduce(0, +)
  }

  func solve2() throws -> Any {
    try input.lines.map(\.integerValues).map(predictValue).map(\.prev).reduce(0, +)
  }

  // MARK: - Private methods

  private func predictValue(of input: [Int]) throws -> (prev: Int, next: Int) {
    guard !input.isEmpty else { throw AOCError("Failed predicting value of empty array") }
    var sequences = [input]

    while sequences.first!.first(where: { $0 != 0 }) != nil {
      var nextSequence = [Int]()
      var prev: Int?

      for value in sequences.first! {
        if let prev { nextSequence.append(value - prev) }
        prev = value
      }
      sequences.insert(nextSequence, at: 0)
    }
    return (
      sequences.reduce(0, { $1.first! - $0 }),
      sequences.reduce(0, { $0 + $1.last! })
    )
  }
}
