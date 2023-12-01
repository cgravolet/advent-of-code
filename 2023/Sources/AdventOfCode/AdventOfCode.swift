import ArgumentParser
import Foundation

enum AdventOfCodeError: Error {
    case notSupported
}

@main
struct AdventOfCode: ParsableCommand {
    @Argument var year: Int
    @Argument var day: Int

    func run() throws {
        let input = try getInputFile()
        let output: String

        switch (year, day) {
        case (2023, 1): output = try Self.AOC202301_part2(input)
        default: throw AdventOfCodeError.notSupported
        }
        print("Advent of Code \(year), Day \(day): \(output)")
    }

    func getInputFile() throws -> String {
        let dayStr = String(format: "%02d", day)
        return try String(contentsOfFile: "../input/\(year)-\(dayStr).txt")
    }
}
