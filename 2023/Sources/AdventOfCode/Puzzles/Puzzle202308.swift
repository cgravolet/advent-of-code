import Algorithms
import Collections
import Foundation

struct Puzzle202308: Puzzle {
  let input: [String]

  init(input: String) {
    self.input = input.lines
  }

  // MARK: - Public methods

  func solve1() throws -> Any {
    let (directions, map) = parseInput(input)

    var current = "AAA"
    var steps = 0

    while current != "ZZZ" {
      current = map[current]![directions[steps % directions.count]]
      steps += 1
    }
    return steps
  }

  func solve2() throws -> Any {
    let (directions, map) = parseInput(input)

    let steps = map.keys.filter({ $0[2] == "A" }).map { current in
      var cur = String(current)
      var steps = 0

      while cur[2] != "Z" {
        cur = map[cur]![directions[steps % directions.count]]
        steps += 1
      }
      return steps
    }
    return steps.reduce(1, lcm)
  }

  // MARK: - Private methods

  private func desertMap(from input: [String]) -> [String: [String]] {
    input.reduce(into: [String: [String]]()) {
      guard let match = $1.firstMatch(of: /([A-Z0-9]+) = \(([A-Z0-9]+), ([A-Z0-9]+)\)/) else { return }
      $0[String(match.1)] = [String(match.2), String(match.3)]
    }
  }

  private func directions(from input: [String]) -> [Int] {
    input[0].map { $0 == "R" ? 1 : 0 }
  }

  private func parseInput(_ input: [String]) -> ([Int], [String: [String]]) {
    (
      directions(from: input),
      desertMap(from: input)
    )
  }
}
