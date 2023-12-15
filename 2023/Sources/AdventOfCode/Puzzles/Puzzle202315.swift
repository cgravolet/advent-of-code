import Algorithms
import Collections
import Foundation

struct Puzzle202315: Puzzle {
  let input: String

  // MARK: - Public methods

  func solve1() throws -> Any {
    input.trimmingCharacters(in: .whitespacesAndNewlines).split(separator: ",")
      .reduce(0, { value, step in
        var cur = 0
        for char in String(step) {
          if let asciiValue = char.asciiValue {
            cur = (cur + Int(asciiValue)) * 17 % 256
          }
        }
        return value + cur
      })
  }

  func solve2() throws -> Any {
    return -1
  }

  // MARK: - Private methods
}
