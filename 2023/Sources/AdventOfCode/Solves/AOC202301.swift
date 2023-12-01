import Algorithms
import Foundation

extension AdventOfCode {
    static func AOC202301(_ input: String) throws -> (String, String) {
        (try solvePart1(input), try solvePart2(input))
    }

    // MARK: - Private methods

    private static func solvePart1(_ input: String) throws -> String {
        input
            .components(separatedBy: .newlines)
            .map(calibrateInput)
            .reduce(0, +)
            .toString()
    }

    private static func solvePart2(_ input: String) throws -> String {
        input
            .components(separatedBy: .newlines)
            .map(calibrateInput_part2)
            .reduce(0, +)
            .toString()
    }

    // MARK: - Helper methods

    private static func calibrateInput(_ input: String) -> Int {
        let output = input.replacingOccurrences(of: "[^0-9]+", with: "", options: .regularExpression)
        if let firstChar = output.first, let lastChar = output.last {
            return Int(String(firstChar) + String(lastChar)) ?? 0
        }
        return 0
    }

    private static func calibrateInput_part2(_ input: String) -> Int {
        // TODO: This is messy! (but it works...)
        let output = input
            .replacingOccurrences(of: "one", with: "one1one", options: .regularExpression)
            .replacingOccurrences(of: "two", with: "two2two", options: .regularExpression)
            .replacingOccurrences(of: "three", with: "three3three", options: .regularExpression)
            .replacingOccurrences(of: "four", with: "four4four", options: .regularExpression)
            .replacingOccurrences(of: "five", with: "five5five", options: .regularExpression)
            .replacingOccurrences(of: "six", with: "six6six", options: .regularExpression)
            .replacingOccurrences(of: "seven", with: "seven7seven", options: .regularExpression)
            .replacingOccurrences(of: "eight", with: "eight8eight", options: .regularExpression)
            .replacingOccurrences(of: "nine", with: "nine9nine", options: .regularExpression)
            .replacingOccurrences(of: "[^0-9]+", with: "", options: .regularExpression)
        if let firstChar = output.first, let lastChar = output.last {
            return Int(String(firstChar) + String(lastChar)) ?? 0
        }
        return 0
    }
}
