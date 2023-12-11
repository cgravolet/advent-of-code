import Foundation

struct Coord2D: Hashable {
  var x: Int
  var y: Int

  var adjacent: [Coord2D] {
    [
      Coord2D(x, y - 1),
      Coord2D(x, y + 1),
      Coord2D(x - 1, y),
      Coord2D(x + 1, y),
    ]
  }

  var diagonal: [Coord2D] {
    [
      Coord2D(x - 1, y - 1),
      Coord2D(x + 1, y - 1),
      Coord2D(x - 1, y + 1),
      Coord2D(x + 1, y + 1),
    ]
  }

  init(_ x: Int, _ y: Int) {
    self.x = x
    self.y = y
  }
}

extension Coord2D: CustomStringConvertible {
  var description: String { "(\(x), \(y))" }
}

extension Coord2D: AdditiveArithmetic {
    static var zero: Coord2D { Coord2D(.zero, .zero) }

    static func + (lhs: Coord2D, rhs: Coord2D) -> Coord2D {
        Coord2D(lhs.x + rhs.x, lhs.y + rhs.y)
    }

    static func - (lhs: Coord2D, rhs: Coord2D) -> Coord2D {
        Coord2D(lhs.x - rhs.x, lhs.y - rhs.y)
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