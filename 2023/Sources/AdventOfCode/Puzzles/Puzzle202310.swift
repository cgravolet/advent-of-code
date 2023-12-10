import Algorithms
import Collections
import Foundation

struct Puzzle202310: Puzzle {
  let map: Map2D

  init(input: String) {
    map = Map2D(input)
  }

  // MARK: - Public methods

  func solve1() throws -> Any {
    guard let start = map.coords(matching: /S/).first else {
      throw AOCError("Could not find start position")
    }
    var distances = [Coord2D: Int]()
    var queue = [start]

    while !queue.isEmpty {
      let coord = queue.remove(at: 0)
      let distance = distances[coord] ?? 0

      for connected in connected(to: coord, in: map) where distances[connected] == nil {
        distances[connected] = distance + 1
        queue.append(connected)
      }
    }

    // DEBUG
    var mutableMap = map
    mutableMap.set(value: "\u{001B}[0;31mS\u{001B}[0m", at: start)
    for (key, _) in distances {
      if let val = map.value(at: key) {
        mutableMap.set(value: "\u{001B}[0;33m\(val)\u{001B}[0m", at: key)
      }
    }
    print("\(mutableMap)\n")

    return distances.values.map({ Int($0) }).max() ?? -1
  }

  func solve2() throws -> Any {
    return -1
  }

  // MARK: - Private methods

  private func connected(to coord: Coord2D, in map: Map2D) -> [Coord2D] {
    guard let value = map.value(at: coord) else { return [] }
    let candidates: [(Coord2D, String)]

    switch value {
    case "S":
      candidates = [
        (coord + Coord2D(x: 0, y: -1), "|7F"),
        (coord + Coord2D(x: -1, y: 0), "-LF"),
        (coord + Coord2D(x: 1, y: 0), "-7J"),
        (coord + Coord2D(x: 0, y: 1), "|LJ")
      ]
    case "-":
      candidates = [
        (coord + Coord2D(x: -1, y: 0), "-LF"),
        (coord + Coord2D(x: 1, y: 0), "-7J")
      ]
    case "|":
      candidates = [
        (coord + Coord2D(x: 0, y: -1), "|7F"),
        (coord + Coord2D(x: 0, y: 1), "|LJ")
      ]
    case "7":
      candidates = [
        (coord + Coord2D(x: -1, y: 0), "-LF"),
        (coord + Coord2D(x: 0, y: 1), "|LJ")
      ]
    case "F":
      candidates = [
        (coord + Coord2D(x: 0, y: 1), "|LJ"),
        (coord + Coord2D(x: 1, y: 0), "-7J")
      ]
    case "J":
      candidates = [
        (coord + Coord2D(x: 0, y: -1), "|7F"),
        (coord + Coord2D(x: -1, y: 0), "-LF")
      ]
    case "L":
      candidates = [
        (coord + Coord2D(x: 0, y: -1), "|7F"),
        (coord + Coord2D(x: 1, y: 0), "-7J")
      ]
    default:
      candidates = []
    }

    var connected = [Coord2D]()

    for candidate in candidates {
      if let val = map.value(at: candidate.0), candidate.1.contains(val) {
        connected.append(candidate.0)
      }
    }
    return connected
  }
}
