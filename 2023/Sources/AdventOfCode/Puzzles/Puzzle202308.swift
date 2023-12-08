import Algorithms
import Collections
import Foundation

struct Puzzle202308: Puzzle {
  let input: String

  // MARK: - Public methods

  func solve1() throws -> Any {
    // Parse the input
    let lines = input.lines
    let directions = lines[0].map { $0 == "R" ? 1 : 0 }
    let map = lines.reduce(into: [String: [String]]()) {
      guard let match = $1.firstMatch(of: /([A-Z]+) = \(([A-Z]+), ([A-Z]+)\)/) else { return }
      $0[String(match.1)] = [String(match.2), String(match.3)]
    }

    // Count the steps
    var steps = 0
    var current = "AAA"

    while current != "ZZZ" {
      let direction = directions[steps % directions.count]
      current = map[current]![direction]
      steps += 1
    }
    return steps
  }

  func solve2() throws -> Any {
    return -1
  }

  // MARK: - Private methods
}
