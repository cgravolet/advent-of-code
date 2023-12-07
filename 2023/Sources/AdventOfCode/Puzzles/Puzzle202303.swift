import Algorithms
import Collections
import Foundation
import RegexBuilder

struct Puzzle202303: Puzzle {
  let map: Map2D

  init(input: String) {
    self.map = Map2D(input)
  }

  // MARK: - Public methods

  func solve1() throws -> Any {
    partNumbers(in: map).map(\.value).reduce(0, +)
  }

  func solve2() throws -> Any {
    gearRatios(in: map).reduce(0, +)
  }

  // MARK: - Private methods

  private func gearRatios(in map: Map2D) -> [Int] {
    let partNumbers = partNumbers(in: map)
    return
      map
      .coords(matching: Regex { One("*") })
      .compactMap { gearRatio(for: $0, partNumbers: partNumbers, in: map) }
  }

  private func gearRatio(for gear: Coord2D, partNumbers: [PartNumber], in map: Map2D) -> Int? {
    let coords = map.adjacentCoords(to: gear)
    let adjacentPartNumbers = partNumbers.filter { partNum in
      coords.first(where: { partNum.contains($0) }) != nil
    }

    if adjacentPartNumbers.count == 2 {
      return adjacentPartNumbers.map(\.value).reduce(1, *)
    }
    return nil
  }

  private func partNumbers(in map: Map2D) -> [PartNumber] {
    let regex = Regex { OneOrMore(.digit) }
    var partNumbers = [PartNumber]()

    for y in 0...map.maxY {
      var partNum = PartNumber(y: y)

      for x in 0...map.maxX {
        if let value = map.value(at: Coord2D(x: x, y: y))?.firstMatch(of: regex)?.0 {
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
    let regex = Regex { OneOrMore(.digit.inverted) }
    let firstAdjacentSymbol = Set(partNumber.coords.flatMap { map.adjacentCoords(to: $0) })
      .subtracting(partNumber.coords)
      .first(where: {
        map.value(at: $0)?.firstMatch(of: regex) != nil
      })
    return firstAdjacentSymbol != nil
  }
}
