import Algorithms
import ArgumentParser
import Foundation

struct Day15: ParsableCommand {
    static let configuration = CommandConfiguration(abstract: "Advent of Code - 2022 December 15", version: "1.0.0")

    // MARK: - Options

    @Option(name: .shortAndLong, help: "Input file path")
    var path: String = "../input/day15.txt"

    // MARK: - Lifecycle

    mutating func run() throws {
        let input = try String(contentsOfFile: path)
        let part1 = try part1(input, row: 2000000)
        let part2 = try part2(input, max: 4000000)
        print("Part 1: \(part1)")
        print("Part 2: \(part2)")
    }

    func part1(_ input: String, row: Int) throws -> Int {
        let start = Date()
        var (minX, maxX, minY, maxY) = (Int.max, Int.min, Int.max, Int.min)
        var env = Set<Coord>()
        let sensors = try parseInput(input).compactMap { pair -> (Coord, Int)? in
            let distance = pair.sensor.manhattanDistance(to: pair.beacon)
            minX = min(minX, pair.sensor.x - distance)
            maxX = max(maxX, pair.sensor.x + distance)
            minY = min(minY, pair.sensor.y - distance)
            maxY = max(maxY, pair.sensor.y + distance)
            env.insert(pair.beacon)
            env.insert(pair.sensor)

            if abs(row - pair.sensor.y) > distance {
                return nil
            }
            return (pair.sensor, distance)
        }
        var count = 0

        for i in minX...maxX {
            let coord = Coord(i, row)
            for (sensor, distance) in sensors where coord.manhattanDistance(to: sensor) <= distance {
                if !env.contains(coord) {
                    count += 1
                    break
                }
            }
        }
        print("Part 1 omplete in \(Date().timeIntervalSince(start)) seconds")
        return count
    }

    func part2(_ input: String, max: Int) throws -> Int {
        let start = Date()
        var env = Set<Coord>()
        let sensors = try parseInput(input).compactMap { pair -> (Coord, Int)? in
            let distance = pair.sensor.manhattanDistance(to: pair.beacon)
            env.insert(pair.beacon)
            env.insert(pair.sensor)
            if (pair.sensor.x < 0 && abs(0 - pair.sensor.x) > distance) ||
               (pair.sensor.y < 0 && abs(0 - pair.sensor.y) > distance) ||
               (pair.sensor.x > max && abs(max - pair.sensor.x) > distance) ||
               (pair.sensor.y > max && abs(max - pair.sensor.y) > distance) {
                return nil
            }
            return (pair.sensor, distance)
        }
        let range = 0...max
        var beacon: Coord?
        let group = DispatchGroup()

        Array(range).chunks(ofCount: max/4).forEach { rangey in
            group.enter()
            DispatchQueue.global(qos: .utility).async {
                defer { group.leave() }
                for y in rangey {
                    for x in range {
                        guard beacon == nil else { return }
                        let coord = Coord(x, y)
                        if env.contains(coord) { continue }
                        var isValid = true

                        for (sensor, distance) in sensors where sensor.manhattanDistance(to: coord) <= distance {
                            isValid = false
                            break
                        }

                        if isValid {
                            beacon = coord
                        }
                    }
                }
            }
        }
        group.wait()
        print("Part 2 omplete in \(Date().timeIntervalSince(start)) seconds")

        if let beacon = beacon {
            return beacon.x * 4000000 + beacon.y
        }
        return -1
    }

    // MARK: - Internal methods

    func parseInput(_ input: String) throws -> [(sensor: Coord, beacon: Coord)] {
        let pattern = #"Sensor at x=(-?\d+), y=(-?\d+): closest beacon is at x=(-?\d+), y=(-?\d+)"#
        let regex = try NSRegularExpression(pattern: pattern)
        let matches = regex.matches(in: input, range: NSRange(input.startIndex..<input.endIndex, in: input))
        return matches.compactMap { getCoordsFromMatch($0, input: input) }
    }

    // MARK: - Private methods

    private func getCoordsFromMatch(_ match: NSTextCheckingResult, input: String) -> (sensor: Coord, beacon: Coord)? {
        guard match.numberOfRanges == 5,
              let group1 = Range(match.range(at: 1), in: input),
              let group2 = Range(match.range(at: 2), in: input),
              let group3 = Range(match.range(at: 3), in: input),
              let group4 = Range(match.range(at: 4), in: input),
              let sx = Int(input[group1]), let sy = Int(input[group2]),
              let bx = Int(input[group3]), let by = Int(input[group4])
        else { return nil }
        return (Coord(sx, sy), Coord(bx, by))
    }
}