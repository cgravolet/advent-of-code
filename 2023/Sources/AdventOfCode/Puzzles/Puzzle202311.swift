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
    let (emptyRows, emptyColumns) = findEmptyRowsAndColumns(from: input)
    let map = Map2D(input)
    let expansionRate = 1_000_000

    return pairs(from: map.data.map(\.key))
      .map { from, to -> Int in
        let fromX = from.x + emptyColumns.filter({ $0 < from.x }).count * expansionRate - emptyColumns.filter({ $0 < from.x }).count
        let toX = to.x + emptyColumns.filter({ $0 < to.x }).count * expansionRate - emptyColumns.filter({ $0 < to.x }).count
        let fromY = from.y + emptyRows.filter({ $0 < from.y }).count * expansionRate - emptyRows.filter({ $0 < from.y }).count
        let toY = to.y + emptyRows.filter({ $0 < to.y }).count * expansionRate - emptyRows.filter({ $0 < to.y }).count
        return Coord2D(fromX, fromY).manhattanDistance(to: Coord2D(toX, toY))
      }
      .reduce(0, +)
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

  private func findEmptyRowsAndColumns(from input: String) -> (rows: Set<Int>, columns: Set<Int>) {
    var emptyColumns = Set<Int>()
    var emptyRows = Set<Int>()
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

    // Find empty rows
    for (y, row) in lines.enumerated() where row.filter({ $0 != "." }).isEmpty {
      emptyRows.insert(y)
    }
    return (emptyRows, emptyColumns)
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
