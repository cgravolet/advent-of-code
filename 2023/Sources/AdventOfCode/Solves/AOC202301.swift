import Algorithms
import Foundation

extension AdventOfCode {
    static func AOC202301(_ input: String) throws -> (String, String) {
        (solve(input, calibrateInput1), solve(input, calibrateInput2))
    }

    // MARK: - Private methods

    private static func solve(_ input: String, _ calibrate: (String) -> Int) -> String {
        input
            .components(separatedBy: .newlines)
            .map(calibrate)
            .reduce(0, +)
            .toString()
    }

    // MARK: - Helper methods

    private static func calibrateInput1(_ input: String) -> Int {
        let output = input.replacingOccurrences(of: "[^0-9]+", with: "", options: .regularExpression)
        if let firstChar = output.first, let lastChar = output.last {
            return Int(String(firstChar) + String(lastChar)) ?? 0
        }
        return 0
    }

    private static func calibrateInput2(_ input: String) -> Int {
        // TODO: This is messy! (but it works...)
        let output = input
            .replacingOccurrences(of: "one", with: "o1e", options: .regularExpression)
            .replacingOccurrences(of: "two", with: "t2o", options: .regularExpression)
            .replacingOccurrences(of: "three", with: "t3e", options: .regularExpression)
            .replacingOccurrences(of: "four", with: "f4r", options: .regularExpression)
            .replacingOccurrences(of: "five", with: "f5e", options: .regularExpression)
            .replacingOccurrences(of: "six", with: "s6x", options: .regularExpression)
            .replacingOccurrences(of: "seven", with: "s7n", options: .regularExpression)
            .replacingOccurrences(of: "eight", with: "e8t", options: .regularExpression)
            .replacingOccurrences(of: "nine", with: "n9e", options: .regularExpression)
            .replacingOccurrences(of: "[^0-9]+", with: "", options: .regularExpression)
        if let firstChar = output.first, let lastChar = output.last {
            return Int(String(firstChar) + String(lastChar)) ?? 0
        }
        return 0
    }
}
