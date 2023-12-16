import Algorithms
import Collections
import Foundation

struct Puzzle202316: Puzzle {
  let input: String

  // MARK: - Public methods

  func solve1() throws -> Any {
    let map = Map2D(input)
    var beams: [(pos: Coord2D, dir: CardinalDirection)?] = [
      (Coord2D(-1, 0), CardinalDirection.east)
    ]
    var energized = [Coord2D: Int]()
    var seen = Set<String>()

    while !beams.compactMap({ $0 }).isEmpty {

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
          case ("-", .north):
            nextDir = .east
            beams.append((nextPos, .west))
          case ("-", .south):
            nextDir = .east
            beams.append((nextPos, .west))
          case ("|", .east):
            nextDir = .north
            beams.append((nextPos, .south))
          case ("|", .west):
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

  func solve2() throws -> Any {
    return -1
  }

  // MARK: - Private methods
}
