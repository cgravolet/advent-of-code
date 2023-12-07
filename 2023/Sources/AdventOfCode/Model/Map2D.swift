import Foundation
import RegexBuilder

struct Map2D {
  let maxX: Int
  let maxY: Int

  private let data: [Coord2D: String]

  init(_ input: String) {
    let lines = input.trimmingCharacters(in: .whitespacesAndNewlines).components(
      separatedBy: .newlines)
    let maxX = lines.first?.count ?? 0
    let maxY = lines.count

    var mutableData = [Coord2D: String]()

    for y in 0..<maxY {
      for x in 0..<maxX {
        let value = lines[y][x]
        if value != "." {
          mutableData[Coord2D(x: x, y: y)] = String(value)
        }
      }
    }
    self.data = mutableData
    self.maxX = maxX - 1
    self.maxY = maxY - 1
  }

  func adjacentCoords(to coord: Coord2D) -> [Coord2D] {
    coord.adjacent.filter { 0...maxX ~= $0.x && 0...maxY ~= $0.y }
  }

  func coords(matching regex: some RegexComponent) -> [Coord2D] {
    data.filter({ $0.value.firstMatch(of: regex) != nil }).map(\.key)
  }

  func value(at coord: Coord2D) -> String? {
    data[coord]
  }
}

extension Map2D: CustomStringConvertible {
  var description: String {
    var output = ""

    for y in 0...maxY {
      for x in 0...maxX {
        output += value(at: .init(x: x, y: y)) ?? "."
      }
      if y < maxY {
        output += "\n"
      }
    }
    return output
  }
}
