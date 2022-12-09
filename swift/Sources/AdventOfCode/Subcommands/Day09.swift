import AdventOfCodeObjc
import ArgumentParser
import Foundation

enum Direction: Equatable {
    case up(Int)
    case right(Int)
    case down(Int)
    case left(Int)

    init?(_ rawValue: String) {
        let components = rawValue.components(separatedBy: .whitespaces)
        guard components.count == 2, let count = Int(components[1]) else { return nil }
        switch components[0] {
        case "U": self = .up(count)
        case "R": self = .right(count)
        case "D": self = .down(count)
        case "L": self = .left(count)
        default: return nil
        }
    }

    var coord: IntPoint {
        switch self {
        case .up: return IntPoint(0, -1)
        case .right: return IntPoint(1, 0)
        case .down: return IntPoint(0, 1)
        case .left: return IntPoint(-1, 0)
        }
    }

    var count: Int {
        switch self {
        case .up(let count): return count
        case .right(let count): return count
        case .down(let count): return count
        case .left(let count): return count
        }
    }
}

struct IntPoint: Hashable {
    let x: Int
    let y: Int

    init(_ x: Int, _ y: Int) {
        self.x = x
        self.y = y
    }

    func isTouching(_ point: IntPoint) -> Bool {
        abs(x - point.x) <= 1 && abs(y - point.y) <= 1
    }

    func move(_ direction: Direction) -> IntPoint {
        let moveCoord = direction.coord
        return IntPoint(x + moveCoord.x, y + moveCoord.y)
    }

    func reposition(near h: IntPoint) -> IntPoint {
        var t = self
        if !t.isTouching(h) {
            let xdiff = h.x - t.x
            let ydiff = h.y - t.y
            let movex = abs(xdiff) > 1 || (abs(xdiff) > 0 && abs(ydiff) > 1)
            let movey = abs(ydiff) > 1 || (abs(ydiff) > 0 && abs(xdiff) > 1)
            t = IntPoint(
                movex ? t.x + (xdiff < 0 ? -1 : 1) : t.x,
                movey ? t.y + (ydiff < 0 ? -1 : 1) : t.y
            )
        }
        return t
    }
}

struct Day09: ParsableCommand {
    static let configuration = CommandConfiguration(abstract: "Advent of Code - 2022 December 9", version: "1.0.0")

    // MARK: - Options

    @Option(name: .shortAndLong, help: "Input file path")
    var path: String = "../input/day09.txt"

    // MARK: - Lifecycle

    mutating func run() throws {
        let instructions = makeInstructions(fromString: try String(contentsOfFile: path))
        let part1 = solve1(instructions: instructions)
        print("Part 1: \(part1)")
    }

    // MARK: - Internal methods

    func makeInstructions(fromString str: String) -> [Direction] {
        str.components(separatedBy: .newlines).compactMap(Direction.init)
    }

    func solve1(instructions: [Direction]) -> Int {
        var h = IntPoint(500, 500)
        var t = IntPoint(500, 500)
        var visited: [IntPoint: Bool] = [t: true]

        for direction in instructions {
            for _ in 0 ..< direction.count {
                h = h.move(direction)
                t = t.reposition(near: h)
                visited[t] = true
            }
        }
        return visited.count
    }
}