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
        let (part1, part2) = (part1(input), part2(input))
        print("Part 1: \(part1)")
        print("Part 2: \(part2)")
    }

    func part1(_ input: String) -> Int {
        0 // TODO
    }

    func part2(_ input: String) -> Int {
        0 // TODO
    }

    // MARK: - Internal methods

    // MARK: - Private methods

}