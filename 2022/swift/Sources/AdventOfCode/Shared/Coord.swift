import Foundation

struct Coord: Hashable, CustomStringConvertible {
    static let zero = Coord(0, 0)

    var x: Int
    var y: Int

    var description: String {
        "(\(x),\(y))"
    }

    init(_ x: Int, _ y: Int) {
        self.x = x
        self.y = y
    }

    func isTouching(_ point: Coord) -> Bool {
        abs(x - point.x) <= 1 && abs(y - point.y) <= 1
    }

    func manhattanDistance(to: Coord) -> Int {
        abs(x - to.x) + abs(y - to.y)
    }
}

extension Coord {
    static func +(lhs: Coord, rhs: Coord) -> Coord {
        Coord(lhs.x + rhs.x, lhs.y + rhs.y)
    }

    static func +=(lhs: inout Coord, rhs: Coord) {
        lhs.x += rhs.x
        lhs.y += rhs.y
    }
}