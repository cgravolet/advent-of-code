import Algorithms
import Collections
import Foundation

struct Puzzle202311: Puzzle {
  let input: String

  // MARK: - Public methods

  func solve1() throws -> Any {
    pairs(from: expandedMap(input).data.map(\.key))
      .map { $0.from.manhattanDistance(to: $0.to) }
      .reduce(0, +)
  }

  func solve2() throws -> Any {
    return -1
  }

  // MARK: - Private methods

  private func expandedMap(_ input: String) -> Map2D {
    var emptyColumns = Set<Int>()
    var expandedMap = ""
    let lines = input.lines

    // Find empty columns
    for x in 0..<lines.first!.count {
      var isEmpty = true

      for row in lines {
        isEmpty = row[x] != "." ? false : isEmpty
      }
      if isEmpty {
        emptyColumns.insert(x)
      }
    }

    // Redraw map
    for (y, row) in lines.enumerated() {
      var expandedRow = ""

      for (x, char) in row.enumerated() {
        let str = String(char)
        expandedRow += emptyColumns.contains(x) ? (str + str) : str
      }
      let isRowEmpty = expandedRow.filter({ $0 != "." }).isEmpty
      expandedMap += isRowEmpty ? (expandedRow + "\n" + expandedRow) : expandedRow

      if y < lines.count - 1 {
        expandedMap += "\n"
      }
    }
    return Map2D(expandedMap)
  }

  private func pairs(from coords: [Coord2D]) -> [(from: Coord2D, to: Coord2D)] {
    var pairs = [(Coord2D, Coord2D)]()
    for (i, coord) in coords.enumerated() {
      for j in i + 1..<coords.count {
        pairs.append((coord, coords[j]))
      }
    }
    return pairs
  }
}
