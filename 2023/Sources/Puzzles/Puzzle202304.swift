import Algorithms
import Collections
import Foundation

struct Puzzle202304: Puzzle {
  let input: String

  // MARK: - Public methods

  func solve1() throws -> Any {
    input
      .components(separatedBy: .newlines)
      .map(points)
      .reduce(0, +)
  }

  func solve2() throws -> Any {
    -1
  }

  // MARK: - Private methods

  func points(from input: String) -> Int {
    guard let sets = input.split(separator: ": ").last?.split(separator: " | ").map(String.init).map(parseNumberSet),
      sets.count == 2
    else { return 0 }
    let winningNumbers = sets[0].intersection(sets[1])
    let winningCount = winningNumbers.count

    if winningCount > 0 {
      let value: UInt = 1 << (winningCount - 1)
      return Int(value)
    }
    return 0
  }

  /// Returns a Set of integers from a string (i.e. "41 48 83 86 17")
  func parseNumberSet(_ input: String) -> Set<Int> {
    var numberSet = Set<Int>()
    for match in input.matches(of: /(\d+)/) {
      if let value = Int(match.output.1) {
        numberSet.insert(value)
      }
    }
    return numberSet
  }
}
