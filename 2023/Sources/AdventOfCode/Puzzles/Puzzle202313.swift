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
    return -1
  }

  // MARK: - Private methods

  private func findIndex(in pattern: String) -> Int? {
    let lines = pattern.lines

    outer: for i in 0..<lines.count {
      let lastIndex = lines.count - 1
      guard i < lastIndex else { break }

      for j in 1...max(1, min(i + 1, lastIndex - i)) where lines[i - j + 1] != lines[i + j] {
        continue outer
      }
      return i + 1
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

  private func summarizePattern(_ pattern: String) -> Int {
    if let rowPattern = findIndex(in: pattern) {
      return rowPattern * 100
    }
    return findIndex(in: rotatePattern(pattern)) ?? 0
  }
}
