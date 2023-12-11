import Foundation
import RegexBuilder

struct Map2D {
  private(set) var data: [Coord2D: String]
  private(set) var maxX: Int
  private(set) var maxY: Int
  private(set) var minX: Int
  private(set) var minY: Int

  init(_ input: String) {
    let lines = input.lines
    let maxX = lines.first?.count ?? 0
    let maxY = lines.count

    var mutableData = [Coord2D: String]()

    for y in 0..<maxY {
      for x in 0..<maxX {
        let value = lines[y][x]
        if value != "." {
          mutableData[Coord2D(x, y)] = String(value)
        }
      }
    }
    self.data = mutableData
    self.maxX = maxX - 1
    self.maxY = maxY - 1
    self.minX = 0
    self.minY = 0
  }

  func adjacentCoords(to coord: Coord2D, includeDiagonal: Bool = true) -> [Coord2D] {
    var adjacent = coord.adjacent
    if includeDiagonal {
      adjacent += coord.diagonal
    }
    return adjacent.filter { minX...maxX ~= $0.x && minY...maxY ~= $0.y }
  }

  mutating func clear() {
    data.removeAll()
  }

  func coords(matching regex: some RegexComponent) -> [Coord2D] {
    data.filter({ $0.value.firstMatch(of: regex) != nil }).map(\.key)
  }

  mutating func scale(width: Int, height: Int) {
    self.maxX += width
    self.maxY += height
    self.minX -= width
    self.minY -= height
  }

  mutating func set(value: String?, at coord: Coord2D) {
    data[coord] = value
  }

  func value(at coord: Coord2D) -> String? {
    data[coord]
  }
}

extension Map2D: CustomStringConvertible {
  var description: String {
    var output = ""

    for y in minY...maxY {
      for x in minX...maxX {
        output += value(at: Coord2D(x, y)) ?? "."
      }
      if y < maxY {
        output += "\n"
      }
    }
    return output
  }
}
