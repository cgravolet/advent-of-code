import Foundation

struct PartNumber: Hashable, CustomStringConvertible {
  var rawValue: String
  var x1: Int
  var x2: Int
  var y: Int

  var coords: Set<Coord2D> {
    var mutableCoords = Set<Coord2D>()
    for x in x1...x2 {
      mutableCoords.insert(Coord2D(x: x, y: y))
    }
    return mutableCoords
  }

  var description: String { "(\(x1)-\(x2),\(y)) \(value)" }
  var value: Int { rawValue.toInt() }

  init(y: Int) {
    self.rawValue = ""
    self.x1 = 0
    self.x2 = 0
    self.y = y
  }
}
