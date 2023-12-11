import Algorithms
import Collections
import Foundation

struct Puzzle202311: Puzzle {
  let input: String

  // MARK: - Public methods

  func solve1() throws -> Any {
    solve(expansionRate: 2, input: input)
  }

  func solve2() throws -> Any {
    solve(expansionRate: 1_000_000, input: input)
  }

  // MARK: - Private methods

  private func expandedCoordinate(_ coord: Coord2D, rate: Int, columns: Set<Int>, rows: Set<Int>)
    -> Coord2D
  {
    let expansionColumnCount = columns.filter({ $0 < coord.x }).count
    let expansionRowCount = rows.filter({ $0 < coord.y }).count
    return Coord2D(
      coord.x + expansionColumnCount * rate - expansionColumnCount,
      coord.y + expansionRowCount * rate - expansionRowCount
    )
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

  private func solve(expansionRate: Int, input: String) -> Int {
    let (emptyRows, emptyColumns) = findEmptyRowsAndColumns(from: input)
    return pairs(from: Map2D(input).data.map(\.key))
      .map {
        let from = expandedCoordinate(
          $0.from, rate: expansionRate, columns: emptyColumns, rows: emptyRows)
        let to = expandedCoordinate(
          $0.to, rate: expansionRate, columns: emptyColumns, rows: emptyRows)
        return from.manhattanDistance(to: to)
      }
      .reduce(0, +)
  }
}
