import Algorithms
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
    static let configuration = CommandConfiguration(abstract: "Advent of Code - 2022 December 10", version: "1.0.0")

    // MARK - Data structures

    // MARK: - Options

    @Option(name: .shortAndLong, help: "Input file path")
    var path: String = "../input/day14.txt"

    // MARK: - Lifecycle

    mutating func run() throws {
        let part1 = part1(input: try String(contentsOfFile: path))
        print("Part 1: \(part1)")
    }

    func part1(input: String) -> Int {
        let instructions = input
            .components(separatedBy: .newlines)
            .map { $0.components(separatedBy: .whitespaces) }

        var environment = Set<IntPoint>()
        var maxX: Int = .min
        var maxY: Int = .min
        var minX: Int = .max

        for instruction in instructions {
            for (i, val) in instruction.enumerated() {
                if val == "->", let from = IntPoint(instruction[i-1]), let to = IntPoint(instruction[i+1]) {
                    getPointsInLine(from: from, to: to)?.forEach {
                        maxX = max(maxX, $0.x)
                        maxY = max(maxY, $0.y)
                        minX = min(minX, $0.x)
                        environment.insert($0)
                    }
                }
            }
        }

        var count = 0
        while let sand = positionSand(inEnvironment: environment, start: IntPoint(500, 0), minX: minX, maxX: maxX, maxY: maxY) {
            environment.insert(sand)
            count += 1
        }
        return count
    }

    // MARK: - Internal methods

    // MARK: - Private methods

    private func getPointsInLine(from: IntPoint, to: IntPoint) -> [IntPoint]? {
        var points = [IntPoint]()

        // Vertical line
        if from.x == to.x {
            for y in min(from.y, to.y)...max(from.y, to.y) {
                points.append(IntPoint(to.x, y))
            }

        // Horizontal line
        } else if from.y == to.y {
            for x in min(from.x, to.x)...max(from.x, to.x) {
                points.append(IntPoint(x, to.y))
            }

        // Diagonal lines not supported
        } else {
            return nil
        }
        return points
    }

    private func positionSand(inEnvironment env: Set<IntPoint>, start: IntPoint, minX: Int, maxX: Int, maxY: Int) -> IntPoint? {
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

            if !(minX...maxX ~= point.x) || point.y > maxY {
                return nil
            }
        }
        return point
    }
}