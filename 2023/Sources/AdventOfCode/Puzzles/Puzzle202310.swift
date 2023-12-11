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
    return loopDistances(in: map, startingAt: start).values.reduce(0, { max($0, Int($1)) })
  }

  func solve2() throws -> Any {
    guard let start = map.coords(matching: /S/).first else {
      throw AOCError("Could not find start position")
    }
    let distances = loopDistances(in: map, startingAt: start)

    // Clear the map of any debris that isn't part of the main loop
    var mutableMap = map
    mutableMap.clear()
    for (key, _) in distances {
      if let val = map.value(at: key) {
        mutableMap.set(value: val, at: key)
      }
    }

    // Fill in enclosed spaces by testing how many boundaries are passed through
    for y in mutableMap.minY...mutableMap.maxY {
      var count = 0
      for x in mutableMap.minX...mutableMap.maxX {
        if let value = mutableMap.value(at: Coord2D(x, y)) {
          count += ("|JL".contains(value) ? 1 : 0)
        } else if count % 2 != 0 {
          mutableMap.set(value: "#", at: Coord2D(x, y))
        }
      }
    }
    return mutableMap.data.count - distances.count
  }

  // MARK: - Private methods

  private func connected(to coord: Coord2D, in map: Map2D) -> [Coord2D] {
    guard let value = map.value(at: coord) else { return [] }
    let candidates: [(Coord2D, String)]

    switch value {
    case "S":
      candidates = [
        (coord + Coord2D(0, -1), "|7F"),
        (coord + Coord2D(-1, 0), "-LF"),
        (coord + Coord2D(1, 0), "-7J"),
        (coord + Coord2D(0, 1), "|LJ")
      ]
    case "-":
      candidates = [
        (coord + Coord2D(-1, 0), "-LF"),
        (coord + Coord2D(1, 0), "-7J")
      ]
    case "|":
      candidates = [
        (coord + Coord2D(0, -1), "|7F"),
        (coord + Coord2D(0, 1), "|LJ")
      ]
    case "7":
      candidates = [
        (coord + Coord2D(-1, 0), "-LF"),
        (coord + Coord2D(0, 1), "|LJ")
      ]
    case "F":
      candidates = [
        (coord + Coord2D(0, 1), "|LJ"),
        (coord + Coord2D(1, 0), "-7J")
      ]
    case "J":
      candidates = [
        (coord + Coord2D(0, -1), "|7F"),
        (coord + Coord2D(-1, 0), "-LF")
      ]
    case "L":
      candidates = [
        (coord + Coord2D(0, -1), "|7F"),
        (coord + Coord2D(1, 0), "-7J")
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

  func loopDistances(in map: Map2D, startingAt start: Coord2D) -> [Coord2D: Int] {
    var distances = [start: 0]
    var queue = [start]

    while !queue.isEmpty {
      let coord = queue.remove(at: 0)
      let distance = distances[coord] ?? 0

      for connected in connected(to: coord, in: map) where distances[connected] == nil {
        distances[connected] = distance + 1
        queue.append(connected)
      }
    }
    return distances
  }
}
