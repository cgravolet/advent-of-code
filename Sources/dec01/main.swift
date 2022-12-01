import ArgumentParser
import Foundation

struct AdventDay01: ParsableCommand {
    static let configuration = CommandConfiguration(abstract: "Advent of Code - 2022 December 1", version: "1.0.0")

    @Option(name: .shortAndLong, help: "Input file path")
    var path: String = "input/dec01.txt"

    mutating func run() throws {
        let calories = try String(contentsOfFile: path)
            .components(separatedBy: .newlines)
            .reduce([0]) { list, item in
                var mutableList = list
                if let calories = Int(item) {
                    mutableList[list.count - 1] += calories
                } else {
                    mutableList.append(0)
                }
                return mutableList
            }
            .sorted(by: >)
            .prefix(3)

        // Most calories
        let mostCalories = calories.first ?? 0
        print("Most calories: \(mostCalories)")

        // Top three
        let topThree = calories.reduce(0, +)
        print("Top three calories combined: \(topThree)")
    }
}

AdventDay01.main()
