import Algorithms
import Collections
import Foundation

struct Puzzle202301: Puzzle {
  let input: [String]

  init(input: String) {
    self.input = input.components(separatedBy: .newlines)
  }

  // MARK: - Public methods

  func solve1() throws -> Any {
    input.map(calibrateInput1).reduce(0, +)
  }

  func solve2() throws -> Any {
    input.map(calibrateInput2).reduce(0, +)
  }

  // MARK: - Private methods

  private func calibrateInput1(_ input: String) -> Int {
    let output = input.replacingOccurrences(of: "[^0-9]+", with: "", options: .regularExpression)
    if let firstChar = output.first, let lastChar = output.last {
      return Int(String(firstChar) + String(lastChar)) ?? 0
    }
    return 0
  }

  private func calibrateInput2(_ input: String) -> Int {
    // TODO: This is messy! (but it works...)
    let output =
      input
      .replacingOccurrences(of: "one", with: "o1e", options: .regularExpression)
      .replacingOccurrences(of: "two", with: "t2o", options: .regularExpression)
      .replacingOccurrences(of: "three", with: "t3e", options: .regularExpression)
      .replacingOccurrences(of: "four", with: "f4r", options: .regularExpression)
      .replacingOccurrences(of: "five", with: "f5e", options: .regularExpression)
      .replacingOccurrences(of: "six", with: "s6x", options: .regularExpression)
      .replacingOccurrences(of: "seven", with: "s7n", options: .regularExpression)
      .replacingOccurrences(of: "eight", with: "e8t", options: .regularExpression)
      .replacingOccurrences(of: "nine", with: "n9e", options: .regularExpression)
      .replacingOccurrences(of: "[^0-9]+", with: "", options: .regularExpression)
    if let firstChar = output.first, let lastChar = output.last {
      return Int(String(firstChar) + String(lastChar)) ?? 0
    }
    return 0
  }
}
