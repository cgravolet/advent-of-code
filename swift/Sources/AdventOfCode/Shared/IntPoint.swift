import Foundation

struct IntPoint: Hashable, CustomStringConvertible {
    static let zero = IntPoint(0, 0)

    var x: Int
    var y: Int

    var description: String {
        "(\(x),\(y))"
    }

    init(_ x: Int, _ y: Int) {
        self.x = x
        self.y = y
    }

    func isTouching(_ point: IntPoint) -> Bool {
        abs(x - point.x) <= 1 && abs(y - point.y) <= 1
    }
}

extension IntPoint {
    static func +(lhs: IntPoint, rhs: IntPoint) -> IntPoint {
        IntPoint(lhs.x + rhs.x, lhs.y + rhs.y)
    }

    static func +=(lhs: inout IntPoint, rhs: IntPoint) {
        lhs.x += rhs.x
        lhs.y += rhs.y
    }
}