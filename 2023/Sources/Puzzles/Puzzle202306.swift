import Algorithms
import Collections
import Foundation

struct Puzzle202306: Puzzle {
  let input: String

  // MARK: - Public methods

  func solve1() throws -> Any {
    parseData1(from: input).map(marginOfError).reduce(1, *)
  }

  func solve2() throws -> Any {
    let (time, dist) = parseData2(from: input)
    return marginOfError(for: time, distance: dist)
  }

  // MARK: - Private methods

  func isWinnable(for t: Int, time: Int, distance: Int) -> Bool {
    (time - t) * t > distance
  }

  func marginOfError(for time: Int, distance: Int) -> Int {
    var start = 0
    var end = 0

    for t in 1..<time where isWinnable(for: t, time: time, distance: distance) {
      start = t
      break
    }

    for t in (1..<time).reversed() where isWinnable(for: t, time: time, distance: distance) {
      end = t
      break
    }
    return end - start + 1
  }

  /// Parses the race data from the given string (i.e. "Time: 7 15 30\nDistance: 9 40 200")
  func parseData1(from input: String) -> [(time: Int, distance: Int)] {
    let data = input.lines.map(\.integerValues)
    guard data.count >= 2 && data[0].count == data[1].count else { return [] }
    var output = [(Int, Int)]()

    for index in 0..<data[0].count {
      output.append((data[0][index], data[1][index]))
    }
    return output
  }

  /// Parses the race data from the given string (i.e. "Time: 7 15 30\nDistance: 9 40 200")
  func parseData2(from input: String) -> (time: Int, distance: Int) {
    let data = input.lines
    let time = Int(data[0].replacingOccurrences(of: "[^0-9]+", with: "", options: .regularExpression))
    let dist = Int(data[1].replacingOccurrences(of: "[^0-9]+", with: "", options: .regularExpression))
    return (time ?? 0, dist ?? 0)
  }
}
