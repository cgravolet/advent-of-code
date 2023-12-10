import Foundation

struct Coord2D: Hashable {
  var x: Int
  var y: Int

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

extension Coord2D: CustomStringConvertible {
  var description: String { "(\(x), \(y))" }
}

extension Coord2D: AdditiveArithmetic {
    static var zero: Coord2D { Coord2D(x: .zero, y: .zero) }

    static func + (lhs: Coord2D, rhs: Coord2D) -> Coord2D {
        Coord2D(x: lhs.x + rhs.x, y: lhs.y + rhs.y)
    }

    static func - (lhs: Coord2D, rhs: Coord2D) -> Coord2D {
        Coord2D(x: lhs.x - rhs.x, y: lhs.y - rhs.y)
    }

    static func += (lhs: inout Coord2D, rhs: Coord2D) {
        lhs.x += rhs.x
        lhs.y += rhs.y
    }

    static func -= (lhs: inout Coord2D, rhs: Coord2D) {
        lhs.x -= rhs.x
        lhs.y -= rhs.y
    }
}