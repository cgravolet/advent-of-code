import Algorithms
import Collections
import Foundation

struct Puzzle202318: Puzzle {
  let input: [String]

  init(input: String) {
    self.input = input.lines
  }

  // MARK: - Public methods

  func solve1() throws -> Any {
    var boundary = 0
    let points =
      input
      .compactMap(parseLine)
      .reduce(
        into: [Coord2D.zero],
        { points, input in
          guard let direction = direction(for: input.0) else { return }
          boundary += input.1
          points.append(
            points.last!
              + (0..<input.1).reduce(into: Coord2D.zero, { val, _ in val += direction.coord }))
        })
    let area =
      abs(
        (0..<points.count - 2).reduce(0, { points[$1].x * points[$1 + 1].y + $0 })
          - (0..<points.count - 2).reduce(0, { points[$1].y * points[$1 + 1].x + $0 })
      ) / 2
    let interior = area - (boundary / 2) + 1

    return boundary + interior
  }

  func solve2() throws -> Any {
    return -1
  }

  // MARK: - Private methods

  private func direction(for char: Character) -> CardinalDirection? {
    switch char {
    case "U": return .north
    case "D": return .south
    case "L": return .west
    case "R": return .east
    default: return nil
    }
  }

  /// Parses a line from the given input (i.e. "R 6 (#70c710)")
  private func parseLine(_ input: String) -> (Character, Int, String)? {
    guard let match = input.firstMatch(of: /([UDLR])\s([0-9]+)\s\(#([A-Za-z0-9]{6})\)/),
      let count = Int(match.output.2)
    else { return nil }
    let char = String(match.output.1)[0]
    let hex = String(match.output.3)
    return (char, count, hex)
  }
}
