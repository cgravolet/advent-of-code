import Foundation

struct Coord2D: Hashable {
  let x: Int
  let y: Int
}

extension Coord2D {
  var adjacent: [Coord2D] {
    [
      Coord2D(x: x, y: y - 1),
      Coord2D(x: x, y: y + 1),
      Coord2D(x: x - 1, y: y - 1),
      Coord2D(x: x + 1, y: y - 1),
      Coord2D(x: x - 1, y: y),
      Coord2D(x: x + 1, y: y),
      Coord2D(x: x - 1, y: y + 1),
      Coord2D(x: x + 1, y: y + 1),
    ]
  }
}