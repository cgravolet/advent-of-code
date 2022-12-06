import ArgumentParser
import Foundation

struct Day03: ParsableCommand {
    static let configuration = CommandConfiguration(abstract: "Advent of Code - 2022 December 3", version: "1.0.0")

    // MARK: - Options

    @Option(name: .shortAndLong, help: "Input file path")
    var path: String = "input/day03.txt"

    // MARK: - Lifecycle

    mutating func run() throws {
        try part1()
        try part2()
    }

    // MARK: - Private methods

    private func getCommonItem(inCompartments compartments: [String]) -> String? {
        let item = compartments.map { Set($0) }
            .reduce(Set<String.Element>()) { $0.count <= 0 ? $1 : $0.intersection($1) }
            .map { String($0) }
            .joined()
        return item.count == 1 ? item : nil
    }

    private func getCompartments(for rucksack: String) -> [String] {
        var rucksack = rucksack
        let mid = rucksack.index(rucksack.startIndex, offsetBy: rucksack.count / 2)
        rucksack.insert(" ", at: mid)
        return rucksack.split(separator: " ").map { String($0) }
    }

    private func getPriority(for item: String) -> Int {
        let priority = " abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
        return item
            .map { el -> Int in
                guard let index = priority.firstIndex(of: el) else { return 0 }
                return priority.distance(from: priority.startIndex, to: index)
            }
            .reduce(0, +)
    }

    private func groupElves(by rucksacks: [String]) -> [[String]] {
        return stride(from: 0, through: rucksacks.count, by: 3).map {
            Array(rucksacks[$0 ..< Swift.min($0 + 3, rucksacks.count)])
        }
    }

    private func part1() throws {
        let sum = try String(contentsOfFile: path)
            .components(separatedBy: .newlines)
            .map(getCompartments(for:))
            .compactMap(getCommonItem(inCompartments:))
            .map(getPriority(for:))
            .reduce(0, +)
        print("Priority sum (part 1): \(sum)")
    }

    private func part2() throws {
        let rucksacks = try String(contentsOfFile: path).components(separatedBy: .newlines)
        let sum = groupElves(by: rucksacks)
            .compactMap(getCommonItem(inCompartments:))
            .map(getPriority(for:))
            .reduce(0, +)
        print("Priority sum of badges (part 2): \(sum)")
    }
}