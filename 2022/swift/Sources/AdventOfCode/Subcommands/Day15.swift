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
        print("Part 1: \(part1)")

        let part2 = try part2(input, max: 4000000)
        print("Part 2: \(part2)")
    }

    func part1(_ input: String, row: Int) throws -> Int {
        let start = Date()
        defer { print("Part 1 complete in \(Date().timeIntervalSince(start).rounded()) seconds") }
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
        return count
    }

    func part2(_ input: String, max: Int) throws -> Int {
        let start = Date()
        defer { print("Part 2 complete in \(Date().timeIntervalSince(start).rounded()) seconds") }
        var candidates = Set<Coord>()
        let sensors = try parseInput(input).map { pair -> (Coord, Int) in
            let distance = pair.sensor.manhattanDistance(to: pair.beacon)
            candidates.formUnion(getCoordsOutsideRange(of: pair.sensor, distance: distance, min: 0, max: max))
            return (pair.sensor, distance)
        }
        candidateLoop: for candidate in candidates {
            for (sensor, distance) in sensors where candidate.manhattanDistance(to: sensor) <= distance {
                continue candidateLoop
            }
            return candidate.x * 4000000 + candidate.y
        }
        return -1
    }

    // MARK: - Internal methods

    func getCoordsOutsideRange(of coord: Coord, distance: Int, min: Int, max: Int) -> Set<Coord> {
        var (coords, step) = (Set<Coord>(), 0)
        for x in (coord.x - distance - 1)...(coord.x + distance + 1) {
            guard (0...max) ~= x else { continue }
            let (uy, dy) = (coord.y - step, coord.y + step)
            if (0...max) ~= uy {
                coords.insert(Coord(x, coord.y - step))
            }
            if (0...max) ~= dy {
                coords.insert(Coord(x, coord.y + step))
            }
            step = x < coord.x ? step + 1 : step - 1
        }
        return coords
    }

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