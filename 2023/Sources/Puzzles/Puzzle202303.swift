import Algorithms
import Collections
import Foundation
import RegexBuilder

struct Puzzle202303: Puzzle {
  let input: String

  // MARK: - Public methods

  func solve1() throws -> Any {
    let map = Map2D(input)
    let candidates = getCoordsForSymbols(in: map).flatMap { getPartNumberCandidates(for: $0, in: map) }
    return Set(candidates)
      .map { getPartNumber(at: $0, in: map) }
      .reduce(0, +)
  }

  func solve2() throws -> Any {
    -1
  }

  // MARK: - Private methods

  private func getCoordsForSymbols(in map: Map2D) -> Set<Coord2D> {
    let regex = Regex {
      OneOrMore(("0"..."9").inverted)
    }
    return Set(map.getCoords(matching: regex))
  }

  private func getPartNumber(at coord: Coord2D, in map: Map2D) -> Int {
    var firstCoord = coord
    while map.getValue(at: Coord2D(x: firstCoord.x - 1, y: firstCoord.y)) != nil {
      firstCoord = Coord2D(x: firstCoord.x - 1, y: firstCoord.y)
    }
    var partNumStr = map.getValue(at: firstCoord)!
    while map.getValue(at: Coord2D(x: firstCoord.x + 1, y: firstCoord.y)) != nil {
      firstCoord = Coord2D(x: firstCoord.x + 1, y: firstCoord.y)
      partNumStr += map.getValue(at: firstCoord)!
    }
    return partNumStr.toInt()
  }

  private func getPartNumberCandidates(for coord: Coord2D, in map: Map2D) -> Set<Coord2D> {
    let regex = Regex {
      OneOrMore(.digit)
    }
    let candidates = map
      .getAdjacentCoords(to: coord)
      .filter { map.getValue(at: $0)?.firstMatch(of: regex) != nil }
      .reduce([Coord2D](), { result, coord in
        if result.contains(Coord2D(x: coord.x - 1, y: coord.y)) {
          return result
        } else if result.contains(Coord2D(x: coord.x + 1, y: coord.y)) {
          return result
        }
        var mutableResult = result
        mutableResult.append(coord)
        return mutableResult
      })
      return Set(candidates)
  }
}
