import Algorithms
import Foundation
import RegexBuilder

extension AdventOfCode {
    static func AOC202302(_ input: String) throws -> (String, String) {
        (try solvePart1(input), try solvePart2(input))
    }

    private struct GameSet {
        let id: Int
        let blue: Int
        let green: Int
        let red: Int
    }

    // MARK: - Private methods

    private static func solvePart1(_ input: String) throws -> String {
        input
            .components(separatedBy: .newlines)
            .compactMap(parseGameSets)
            .filter { isPossible($0, blue: 14, green: 13, red: 12) }
            .reduce(0, { $0 + ($1.first?.id ?? 0) })
            .toString()
    }

    private static func solvePart2(_ input: String) throws -> String {
        input
            .components(separatedBy: .newlines)
            .compactMap(parseGameSets)
            .map(getMinimumSetPower)
            .reduce(0, +)
            .toString()
    }

    // MARK: - Helper methods

    private static func getMinimumSetPower(from gameSets: [GameSet]) -> Int {
        let blue = gameSets.map(\.blue).max() ?? 0
        let green = gameSets.map(\.green).max() ?? 0
        let red = gameSets.map(\.red).max() ?? 0
        return blue * green * red
    }

    private static func isPossible(_ gameSets: [GameSet], blue: Int, green: Int, red: Int) -> Bool {
        let invalidSets = gameSets.filter {
            $0.blue > blue || $0.green > green || $0.red > red
        }
        return invalidSets.count == 0
    }

    private static func parseGameId(_ input: String) -> Int {
        Int(input.replacingOccurrences(of: "[^0-9]+", with: "", options: .regularExpression)) ?? 0
    }

    private static func parseGameSet(_ input: String, id: Int) -> GameSet {
        var blue = 0
        var green = 0
        var red = 0
        input.split(separator: ",")
            .forEach {
                let num = String($0).toInt()
                if $0.contains("blue") {
                    blue = num
                } else if $0.contains("green") {
                    green = num
                } else if $0.contains("red") {
                    red = num
                }
            }
        return .init(id: id, blue: blue, green: green, red: red)
    }

    private static func parseGameSets(_ input: String) -> [GameSet]? {
        let components = input.split(separator: ":")
        guard components.count == 2 else { return nil }
        let gameId = String(components[0]).toInt()
        return components[1].split(separator: ";").map { parseGameSet(String($0), id: gameId) }
    }
}
