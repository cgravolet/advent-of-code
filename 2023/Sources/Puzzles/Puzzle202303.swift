import Algorithms
import Collections
import Foundation
import RegexBuilder

struct Puzzle202303: Puzzle {
  let input: String

  // MARK: - Public methods

  func solve1() throws -> Any {
    let map = Map2D(input)
    let regex = Regex {
      OneOrMore(.digit)
    }
    var partNumbers = [PartNumber]()

    // Get a list of all partnumbers
    for y in 0...map.maxY {
      var partNum = PartNumber(y: y)

      for x in 0...map.maxX {
        if let value = map.getValue(at: Coord2D(x: x, y: y))?.firstMatch(of: regex)?.0 {
          if partNum.rawValue.isEmpty {
            partNum.x1 = x
          }
          partNum.rawValue += value
          partNum.x2 = x
        } else if !partNum.rawValue.isEmpty {
          partNumbers.append(partNum)
          partNum = PartNumber(y: y)
        }
      }

      if !partNum.rawValue.isEmpty {
        partNumbers.append(partNum)
      }
    }

    return
      partNumbers
      .filter { isPartNumber($0, in: map) }
      .map(\.value)
      .reduce(0, +)
  }

  func solve2() throws -> Any {
    -1
  }

  // MARK: - Private methods

  private func isPartNumber(_ partNumber: PartNumber, in map: Map2D) -> Bool {
    let regex = Regex {
      OneOrMore(.digit.inverted)
    }
    let candidates = Set(partNumber.coords.flatMap { map.getAdjacentCoords(to: $0) })
      .subtracting(partNumber.coords)
      .filter {
        if map.getValue(at: $0)?.firstMatch(of: regex) != nil {
          return true
        }
        return false
      }
    return !candidates.isEmpty
  }
}
