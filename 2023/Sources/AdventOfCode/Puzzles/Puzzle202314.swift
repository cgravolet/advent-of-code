import Algorithms
import Collections
import Foundation

private enum TiltDirection: CaseIterable {
  case north, west, south, east
}

struct Puzzle202314: Puzzle {
  let input: String

  // MARK: - Public methods

  func solve1() throws -> Any {
    calculateLoad(from: tiltMap(Map2D(input), direction: .north))
  }

  func solve2() throws -> Any {
    var cache = [String: Map2D]()
    var iterations = [String: Int]()
    var mutableMap = Map2D(input)

    for i in 0..<1_000_000_000 {
      let key = mutableMap.description

      if let index = iterations[key] {
        for _ in 0..<(1_000_000_000 - i) % (i - index) {
          if let value = cache[mutableMap.description] {
            mutableMap = value
          } else {
            mutableMap = spinCycle(map: mutableMap)
          }
        }
        return calculateLoad(from: mutableMap)
      } else {
        mutableMap = spinCycle(map: mutableMap)
        cache[key] = mutableMap
        iterations[key] = i
      }
    }
    return calculateLoad(from: mutableMap)
  }

  // MARK: - Private methods

  private func calculateLoad(from map: Map2D) -> Int {
    map.coords(matching: /O/).reduce(0, { $0 + (map.maxY + 1 - $1.y) })
  }

  private func spinCycle(map: Map2D) -> Map2D {
    var mutableMap = map
    for direction in TiltDirection.allCases {
      mutableMap = tiltMap(mutableMap, direction: direction)
    }
    return mutableMap
  }

  private func tiltMap(_ map: Map2D, direction: TiltDirection) -> Map2D {
    let roundRocks = map.coords(matching: /O/).sorted(by: {
      switch direction {
      case .north: $0.y < $1.y
      case .west: $0.x < $1.x
      case .south: $0.y > $1.y
      case .east: $0.x > $1.x
      }
    })
    var mutableMap = map

    let move: Coord2D
    switch direction {
    case .north: move = Coord2D(0, -1)
    case .west: move = Coord2D(-1, 0)
    case .south: move = Coord2D(0, 1)
    case .east: move = Coord2D(1, 0)
    }

    for rock in roundRocks {
      var curPos = rock
      var nextPos = curPos + move

      while mutableMap.value(at: nextPos) == nil && nextPos.x >= map.minX && nextPos.x <= map.maxX
        && nextPos.y >= map.minY && nextPos.y <= map.maxY
      {
        curPos = nextPos
        nextPos = curPos + move
      }
      mutableMap.set(value: nil, at: rock)
      mutableMap.set(value: "O", at: curPos)
    }
    return mutableMap
  }
}
