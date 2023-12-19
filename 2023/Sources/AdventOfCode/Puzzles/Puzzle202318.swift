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
    cubicMeters(of: input.compactMap(parseLine1))
  }

  func solve2() throws -> Any {
    cubicMeters(of: input.compactMap(parseLine2))
  }

  // MARK: - Private methods

  /// Uses shoelace formula and Pick's theorem to calculate area and interior of polygon using the given dig plan
  /// See: https://www.youtube.com/watch?v=FSWPX0XB7a0 was very helpful in explaining shoelace formula
  /// See: https://en.wikipedia.org/wiki/Pick's_theorem
  private func cubicMeters(of plan: [(CardinalDirection, Int)]) -> Int {
    var boundary = 0
    let points = plan.reduce(
      into: [Coord2D.zero],
      { points, step in
        boundary += step.1
        points.append(
          points.last! + (0..<step.1).reduce(into: Coord2D.zero, { val, _ in val += step.0.coord }))
      })
    let area =
      abs(
        (0..<points.count - 2).reduce(0, { points[$1].x * points[$1 + 1].y + $0 })
          - (0..<points.count - 2).reduce(0, { points[$1].y * points[$1 + 1].x + $0 })
      ) / 2
    return boundary + area - (boundary / 2) + 1
  }

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
  private func parseLine1(_ input: String) -> (CardinalDirection, Int)? {
    guard let match = input.firstMatch(of: /([UDLR])\s([0-9]+)\s\(#([A-Za-z0-9]{6})\)/),
      let count = Int(match.output.2),
      let direction = direction(for: String(match.output.1)[0])
    else { return nil }
    return (direction, count)
  }

  /// Parses a line from the given input (i.e. "R 6 (#70c710)")
  private func parseLine2(_ input: String) -> (CardinalDirection, Int)? {
    guard let match = input.firstMatch(of: /([UDLR])\s([0-9]+)\s\(#([A-Za-z0-9]{6})\)/) else {
      return nil
    }
    let hex = String(match.output.3)
    guard let direction = direction(for: "RDLU"[Int(String(hex[5])) ?? 0]),
      let count = Int(String(hex.prefix(5)), radix: 16)
    else { return nil }
    return (direction, count)
  }
}
