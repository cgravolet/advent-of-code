import Algorithms
import Collections
import Foundation
import RegexBuilder

struct Puzzle202303: Puzzle {
  let input: String

  // MARK: - Public methods

  func solve1() throws -> Any {
    getPartNumbers(in: Map2D(input))
      .map(\.value)
      .reduce(0, +)
  }

  func solve2() throws -> Any {
    let map = Map2D(input)
    let regex = Regex {
      One("*")
    }
    let partNumbers = getPartNumbers(in: map)

    return map.getCoords(matching: regex)
      .compactMap { getGearRatio(for: $0, partNumbers: partNumbers, in: map) }
      .reduce(0, +)
  }

  // MARK: - Private methods

  private func getGearRatio(for gear: Coord2D, partNumbers: [PartNumber], in map: Map2D) -> Int? {
    let adjacentCoords = map.getAdjacentCoords(to: gear)
    let adjacentPartNumbers = partNumbers.filter { partNum in
      adjacentCoords.first(where: { partNum.contains($0) }) != nil
    }
    if adjacentPartNumbers.count == 2 {
      return adjacentPartNumbers[0].value * adjacentPartNumbers[1].value
    }
    return nil
  }

  private func getPartNumbers(in map: Map2D) -> [PartNumber] {
    var partNumbers = [PartNumber]()

    let regex = Regex {
      OneOrMore(.digit)
    }

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
    return partNumbers.filter { isPartNumber($0, in: map) }
  }

  private func isPartNumber(_ partNumber: PartNumber, in map: Map2D) -> Bool {
    let regex = Regex {
      OneOrMore(.digit.inverted)
    }
    let firstAdjacentSymbol = Set(partNumber.coords.flatMap { map.getAdjacentCoords(to: $0) })
      .subtracting(partNumber.coords)
      .first(where: {
        if map.getValue(at: $0)?.firstMatch(of: regex) != nil {
          return true
        }
        return false
      })
    return firstAdjacentSymbol != nil
  }
}
