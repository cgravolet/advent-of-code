import ArgumentParser
import Foundation

fileprivate extension IntPoint {
    init?(_ token: String) {
        let components = token.components(separatedBy: ",").compactMap(Int.init)
        guard components.count == 2 else {
            return nil
        }
        self.init(components[0], components[1])
    }
}

struct Day14: ParsableCommand {
    static let configuration = CommandConfiguration(abstract: "Advent of Code - 2022 December 14", version: "1.0.0")

    // MARK: - Options

    @Option(name: .shortAndLong, help: "Input file path")
    var path: String = "../input/day14.txt"

    // MARK: - Lifecycle

    mutating func run() throws {
        let input = try String(contentsOfFile: path)
        let (part1, part2) = (part1(input), part2(input))
        print("Part 1: \(part1)")
        print("Part 2: \(part2)")
    }

    func part1(_ input: String) -> Int {
        var (env, maxY) = makeEnvironment(input: input)
        var count = 0
        while let sand = positionSand(inEnvironment: env, start: IntPoint(500, 0), maxY: maxY) {
            env.insert(sand)
            count += 1
        }
        return count
    }

    func part2(_ input: String) -> Int {
        var (env, maxY) = makeEnvironment(input: input)
        var count = 0
        while let sand = positionSand(inEnvironment: env, start: IntPoint(500, 0), maxY: maxY, floor: maxY + 2) {
            env.insert(sand)
            count += 1
        }
        return count
    }

    // MARK: - Internal methods

    func makeEnvironment(input: String) -> (Set<IntPoint>, Int) {
        var (env, maxY) = (Set<IntPoint>(), Int.min)
        input.components(separatedBy: .newlines)
            .map { $0.components(separatedBy: .whitespaces) }
            .forEach { instruction in
                for (i, val) in instruction.enumerated() where val == "->" {
                    guard let from = IntPoint(instruction[i-1]), let to = IntPoint(instruction[i+1]) else { continue }
                    getPointsInLine(from: from, to: to)?.forEach {
                        maxY = max(maxY, $0.y)
                        env.insert($0)
                    }
                }
            }
        return (env, maxY)
    }

    // MARK: - Private methods

    private func getPointsInLine(from: IntPoint, to: IntPoint) -> [IntPoint]? {
        var points = [IntPoint]()
        if from.x == to.x {
            for y in min(from.y, to.y)...max(from.y, to.y) {
                points.append(IntPoint(to.x, y))
            }
        } else if from.y == to.y {
            for x in min(from.x, to.x)...max(from.x, to.x) {
                points.append(IntPoint(x, to.y))
            }
        } else {
            return nil // Diagonal lines not supported
        }
        return points
    }

    private func positionSand(inEnvironment env: Set<IntPoint>, start: IntPoint, maxY: Int,
                              floor: Int? = nil) -> IntPoint? {
        guard !env.contains(start) else { return nil }
        let (down, left, right) = (IntPoint(0, 1), IntPoint(-1, 1), IntPoint(1, 1))
        var point = start

        while true {
            if !env.contains(point + down) {
                point += down
            } else if !env.contains(point + left) {
                point += left
            } else if !env.contains(point + right) {
                point += right
            } else {
                break
            }

            if let floor = floor {
                if point.y + 1 >= floor {
                    break
                }
            } else if point.y >= maxY {
                return nil
            }
        }
        return point
    }
}