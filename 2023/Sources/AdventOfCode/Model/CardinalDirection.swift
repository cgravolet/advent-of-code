import Foundation

enum CardinalDirection: CaseIterable {
  case north, west, south, east

  var coord: Coord2D {
    switch self {
    case .north: return Coord2D(0, -1)
    case .west: return Coord2D(-1, 0)
    case .south: return Coord2D(0, 1)
    case .east: return Coord2D(1, 0)
    }
  }
}