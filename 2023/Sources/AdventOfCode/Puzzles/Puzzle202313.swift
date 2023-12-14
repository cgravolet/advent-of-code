import Algorithms
import Collections
import Foundation

struct Puzzle202313: Puzzle {
  let input: String

  // MARK: - Public methods

  func solve1() throws -> Any {
    input.split(separator: "\n\n").reduce(0, { $0 + summarizePattern(String($1)) })
  }

  func solve2() throws -> Any {
    input.split(separator: "\n\n").reduce(0, { $0 + summarizePattern(String($1), smudges: 1) })
  }

  // MARK: - Private methods

  private func compareLine(_ lhs: String, _ rhs: String) -> Int {
    var diffCount = 0
    for i in 0..<lhs.count where lhs[i] != rhs[i] {
      diffCount += 1
    }
    return diffCount
  }

  private func findIndex(in pattern: String, smudges: Int = 0) -> Int? {
    let lines = pattern.lines

    outer: for i in 0..<lines.count {
      let lastIndex = lines.count - 1
      guard i < lastIndex else { break }
      var diffsAllowed = smudges

      for j in 1...max(1, min(i + 1, lastIndex - i)) {
        diffsAllowed -= compareLine(lines[i - j + 1], lines[i + j])

        if diffsAllowed < 0 {
          continue outer
        }
      }
      if diffsAllowed == 0 {
        return i + 1
      }
    }
    return nil
  }

  private func rotatePattern(_ pattern: String) -> String {
    let lines = pattern.lines
    var output = ""

    for i in 0..<lines[0].count {
      for j in (0..<lines.count).reversed() {
        output += String(lines[j][i])
      }
      if i < lines[0].count - 1 {
        output += "\n"
      }
    }
    return output
  }

  private func summarizePattern(_ pattern: String, smudges: Int = 0) -> Int {
    if let rowPattern = findIndex(in: pattern, smudges: smudges) {
      return rowPattern * 100
    }
    return findIndex(in: rotatePattern(pattern), smudges: smudges) ?? 0
  }
}
