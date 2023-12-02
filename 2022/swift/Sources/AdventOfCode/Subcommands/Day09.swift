import ArgumentParser
import Foundation

fileprivate extension Coord {
    func move(_ direction: Day09.Direction) -> Coord {
        let moveCoord = direction.coord
        return Coord(x + moveCoord.x, y + moveCoord.y)
    }

    func reposition(near h: Coord) -> Coord {
        guard !isTouching(h) else { return self }
        let (xdiff, ydiff) = (h.x - x, h.y - y)
        let movex = abs(xdiff) > 1 || (abs(xdiff) > 0 && abs(ydiff) > 1)
        let movey = abs(ydiff) > 1 || (abs(ydiff) > 0 && abs(xdiff) > 1)
        return Coord(
            movex ? x + (xdiff < 0 ? -1 : 1) : x,
            movey ? y + (ydiff < 0 ? -1 : 1) : y
        )
    }
}

struct Day09: ParsableCommand {
    static let configuration = CommandConfiguration(abstract: "Advent of Code - 2022 December 9", version: "1.0.0")

    // MARK - Data structures

    enum Direction: Equatable {
        case up(Int), right(Int), down(Int), left(Int)

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

        var coord: Coord {
            switch self {
            case .up: return Coord(0, -1)
            case .right: return Coord(1, 0)
            case .down: return Coord(0, 1)
            case .left: return Coord(-1, 0)
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

    // MARK: - Options

    @Option(name: .shortAndLong, help: "Input file path")
    var path: String = "../../input/2022-09.txt"

    // MARK: - Lifecycle

    mutating func run() throws {
        let instructions = makeInstructions(fromString: try String(contentsOfFile: path))
        let part1 = solve(instructions: instructions, ropeSize: 2)
        let part2 = solve(instructions: instructions, ropeSize: 10)
        print("Part 1: \(part1)")
        print("Part 2: \(part2)")
    }

    // MARK: - Internal methods

    func makeInstructions(fromString str: String) -> [Direction] {
        str.components(separatedBy: .newlines).compactMap(Direction.init)
    }

    func solve(instructions: [Direction], ropeSize: Int) -> Int {
        guard ropeSize > 0 else { return 0 }
        var rope = [Coord](repeating: Coord(500, 500), count: ropeSize)
        var visited = Set<Coord>()

        for direction in instructions {
            for _ in 0 ..< direction.count {
                rope[0] = rope[0].move(direction)
                for i in 1 ..< rope.count {
                    rope[i] = rope[i].reposition(near: rope[i-1])
                }
                visited.insert(rope[rope.count-1])
            }
        }
        return visited.count
    }
}
