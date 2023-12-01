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
        let output: (String, String)

        switch (year, day) {
        case (2023, 1): output = try Self.AOC202301(input)
        case (2023, 2): output = try Self.AOC202302(input)
        default: throw AdventOfCodeError.notSupported
        }
        print("Advent of Code \(year), Day \(day): \(output)")
    }

    func getInputFile() throws -> String {
        let dayStr = String(format: "%02d", day)
        return try String(contentsOfFile: "../input/\(year)-\(dayStr).txt")
    }
}
