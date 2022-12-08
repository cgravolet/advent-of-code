import AdventOfCodeObjc
import ArgumentParser
import Foundation

struct Day08: ParsableCommand {
    static let configuration = CommandConfiguration(abstract: "Advent of Code - 2022 December 7", version: "1.0.0")

    // MARK: - Options

    @Option(name: .shortAndLong, help: "Input file path")
    var path: String = "input/day08.txt"

    // MARK: - Lifecycle

    mutating func run() throws {
        AdventOfCodeObjc.Day08(path: path).run()
    }
}