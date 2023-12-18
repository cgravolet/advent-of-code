import Algorithms
import Collections
import Foundation

private struct PathNode: Hashable {
  let coord: Coord2D
  let direction: CardinalDirection?
  let count: Int
}

struct Puzzle202317: Puzzle {
  fileprivate typealias Path = [PathNode: [Coord2D]]

  let map: Map2D

  init(input: String) {
    self.map = Map2D(input)
  }

  // MARK: - Public methods

  func solve1() throws -> Any {
    let start = Coord2D(map.minX, map.minY)
    let end = Coord2D(map.maxX, map.maxY)
    return findShortestDistance(from: start, to: end, in: map) ?? -1
  }

  func solve2() throws -> Any {
    let start = Coord2D(map.minX, map.minY)
    let end = Coord2D(map.maxX, map.maxY)
    return findShortestDistanceUltra(from: start, to: end, in: map) ?? -1
  }

  // MARK: - Private methods

  private func getAdjacentCoords(to coord: Coord2D, direction: CardinalDirection?) -> [Coord2D] {
    var coords = Set(CardinalDirection.allCases.map { coord + $0.coord })

    switch direction {
    case .north: coords.remove(coord + CardinalDirection.south.coord)
    case .west: coords.remove(coord + CardinalDirection.east.coord)
    case .south: coords.remove(coord + CardinalDirection.north.coord)
    case .east: coords.remove(coord + CardinalDirection.west.coord)
    case .none: break
    }
    return Array(coords)
  }

  private func findShortestDistance(from start: Coord2D, to end: Coord2D, in map: Map2D) -> Int? {
    guard let startValue = map.value(at: start), let startDistance = Int(startValue) else { return -1 }
    var path = Path()
    var queue = PriorityQueue()
    queue.enqueue((start, 0, startDistance, nil, 0, [start]))

    while !queue.isEmpty {
      guard let node = queue.dequeue() else { continue }
      guard node.coord != end else { return node.distance }

      for coord in getAdjacentCoords(to: node.coord, direction: node.direction) {
        guard let distValue = map.value(at: coord), let distance = Int(distValue) else { continue }
        let direction = CardinalDirection.allCases.first(where: { node.coord + $0.coord == coord })
        let count = direction == node.direction ? node.count + 1 : 1
        let pathNode = PathNode(coord: coord, direction: direction, count: count)

        guard path[pathNode] == nil, count <= 3 else { continue }
        queue.enqueue((coord, node.distance + distance, distance, direction, count, node.path + [coord]))
        path[pathNode] = node.path + [coord]
      }
    }
    return nil
  }

  private func findShortestDistanceUltra(from start: Coord2D, to end: Coord2D, in map: Map2D) -> Int? {
    guard let startValue = map.value(at: start), let startDistance = Int(startValue) else { return -1 }
    var path = Path()
    var queue = PriorityQueue()
    queue.enqueue((start, 0, startDistance, nil, 0, [start]))

    while !queue.isEmpty {
      guard let node = queue.dequeue() else { continue }
      guard node.coord != end else {
        if node.count < 4 {
          continue
        }
        return node.distance
      }
      let adjacent: [Coord2D]

      if let direction = node.direction, node.count < 4 {
        adjacent = [node.coord + direction.coord]
      } else {
        adjacent = getAdjacentCoords(to: node.coord, direction: node.direction)
      }

      for coord in adjacent {
        guard let distValue = map.value(at: coord), let distance = Int(distValue) else { continue }
        let direction = CardinalDirection.allCases.first(where: { node.coord + $0.coord == coord })
        let count = direction == node.direction ? node.count + 1 : 1
        let pathNode = PathNode(coord: coord, direction: direction, count: count)

        guard path[pathNode] == nil, count <= 10 else { continue }
        queue.enqueue((coord, node.distance + distance, distance, direction, count, node.path + [coord]))
        path[pathNode] = node.path + [coord]
      }
    }
    return nil
  }
}

private struct PriorityQueue {
  typealias Element = (coord: Coord2D, distance: Int, weight: Int, direction: CardinalDirection?, count: Int, path: [Coord2D])

  private var data = [Element]()

  var isEmpty: Bool { data.isEmpty }

  mutating func enqueue(_ value: Element) {
    data.append(value)
  }

  mutating func dequeue() -> Element? {
    guard !data.isEmpty else { return nil }
    var sorted = data.sorted {
      if $0.distance == $1.distance {
        return $0.weight < $1.weight
      }
      return $0.distance < $1.distance
    }
    let first = sorted.remove(at: 0)
    data = sorted
    return first
  }
}