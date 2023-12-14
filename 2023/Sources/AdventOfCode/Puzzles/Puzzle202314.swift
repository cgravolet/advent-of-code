import Algorithms
import Collections
import Foundation

struct Puzzle202314: Puzzle {
  let input: String

  // MARK: - Public methods

  func solve1() throws -> Any {
    calculateLoad(from: tiltMap(Map2D(input)))
  }

  func solve2() throws -> Any {
    return -1
  }

  // MARK: - Private methods

  private func calculateLoad(from map: Map2D) -> Int {
    map.coords(matching: /O/).reduce(0, { $0 + (map.maxY + 1 - $1.y) })
  }

  private func tiltMap(_ map: Map2D) -> Map2D {
    var mutableMap = map
    let roundRocks = map.coords(matching: /O/).sorted(by: { $0.y < $1.y })

    for rock in roundRocks {
      var newY = rock.y

      for y in (0..<rock.y).reversed() {
        if mutableMap.value(at: Coord2D(rock.x, y)) == nil {
          newY = y
        } else {
          break
        }
      }
      mutableMap.set(value: nil, at: rock)
      mutableMap.set(value: "O", at: Coord2D(rock.x, newY))
    }
    return mutableMap
  }
}
