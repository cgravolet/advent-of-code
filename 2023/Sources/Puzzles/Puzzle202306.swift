import Algorithms
import Collections
import Foundation

struct Puzzle202306: Puzzle {
  let input: String

  // MARK: - Public methods

  func solve1() throws -> Any {
    let data = parseData(from: input)
    var margins = [Int]()

    for race in data {
      var start = 0
      for t in 1..<race.time where (race.time - t) * t > race.distance {
        start = t
        break
      }
      var end = 0
      for t in (1..<race.time).reversed() where (race.time - t) * t > race.distance {
        end = t
        break
      }
      margins.append(end - start + 1)
    }
    return margins.reduce(1, *)
  }

  func solve2() throws -> Any {
    -1
  }

  // MARK: - Private methods

  /// Parses the race data from the given string (i.e. "Time: 7 15 30\nDistance: 9 40 200")
  func parseData(from input: String) -> [(time: Int, distance: Int)] {
    let data = input.lines.map(\.integerValues)
    guard data.count >= 2 && data[0].count == data[1].count else { return [] }
    var output = [(Int, Int)]()

    for index in 0..<data[0].count {
      output.append((data[0][index], data[1][index]))
    }
    return output
  }
}
