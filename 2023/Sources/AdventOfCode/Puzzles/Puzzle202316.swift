import Algorithms
import Collections
import Foundation

struct Puzzle202316: Puzzle {
  let map: Map2D

  init(input: String) {
    self.map = Map2D(input)
  }

  // MARK: - Public methods

  func solve1() throws -> Any {
    energizeMap(map, start: Coord2D(-1, 0), direction: .east)
  }

  func solve2() throws -> Any {
    var startTiles = [Coord2D: CardinalDirection]()

    for x in map.minX...map.maxX {
      startTiles[Coord2D(x, map.minY - 1)] = .south
      startTiles[Coord2D(x, map.maxY + 1)] = .north
    }

    for y in map.minY...map.maxY {
      startTiles[Coord2D(map.minX - 1, y)] = .east
      startTiles[Coord2D(map.maxX + 1, y)] = .west
    }
    var maxEnergized = 0

    for (coord, direction) in startTiles {
      maxEnergized = max(maxEnergized, energizeMap(map, start: coord, direction: direction))
    }
    return maxEnergized
  }

  // MARK: - Private methods

  private func energizeMap(_ map: Map2D, start: Coord2D, direction: CardinalDirection) -> Int {
    var beams: [(pos: Coord2D, dir: CardinalDirection)?] = [(start, direction)]
    var energized = [Coord2D: Int]()
    var seen = Set<String>()

    while !beams.filter({ $0 != nil }).isEmpty {

      for i in 0..<beams.count {
        guard let beam = beams[i] else { continue }
        let nextPos = beam.pos + beam.dir.coord
        var nextDir = beam.dir

        if let mirror = map.value(at: nextPos) {
          switch (mirror, beam.dir) {
          case ("/", .east): nextDir = .north
          case ("/", .west): nextDir = .south
          case ("/", .north): nextDir = .east
          case ("/", .south): nextDir = .west
          case ("\\", .east): nextDir = .south
          case ("\\", .west): nextDir = .north
          case ("\\", .north): nextDir = .west
          case ("\\", .south): nextDir = .east
          case ("-", .north), ("-", .south):
            nextDir = .east
            beams.append((nextPos, .west))
          case ("|", .east), ("|", .west):
            nextDir = .north
            beams.append((nextPos, .south))
          default: break
          }
        }
        let key = "\(nextPos) \(nextDir)"

        if !map.contains(nextPos) || seen.contains(key) {
          beams[i] = nil
          continue
        }
        let energizeValue = energized[nextPos] ?? 0
        energized[nextPos] = energizeValue + 1
        beams[i] = (nextPos, nextDir)
        seen.insert(key)
      }
    }
    return energized.count
  }
}
