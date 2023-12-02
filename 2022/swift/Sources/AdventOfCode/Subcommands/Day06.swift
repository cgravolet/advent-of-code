import ArgumentParser
import Foundation

struct Day06: ParsableCommand {
    static let configuration = CommandConfiguration(abstract: "Advent of Code - 2022 December 6", version: "1.0.0")

    // MARK: - Options

    @Option(name: .shortAndLong, help: "Input file path")
    var path: String = "../../input/2022-06.txt"

    // MARK: - Lifecycle

    mutating func run() throws {
        let input = try String(contentsOfFile: path)
        let answer1 = try findMarker(inStream: input, size: 4)
        let answer2 = try findMarker(inStream: input, size: 14)
        print("Day 6 answer (part 1): \(answer1)")
        print("Day 6 answer (part 2): \(answer2)")
    }

    // MARK: - Internal methods

    func findMarker(inStream stream: String, size: Int) throws -> Int {
        var charSet = Array<String.Element>()

        for (i, char) in stream.enumerated() {
            charSet.append(char)

            if charSet.count > size {
                charSet.remove(at: 0)
            }

            if Set(charSet).count == size {
                return i + 1
            }
        }
        throw NSError(domain: "com.adventofcode.day06", code: 404)
    }
}