import ArgumentParser
import Foundation

extension ClosedRange {
    func hasContainment(withRange range: ClosedRange) -> Bool {
        (self ~= range.lowerBound && self ~= range.upperBound) || (range ~= lowerBound && range ~= upperBound)
    }
}

struct Day04: ParsableCommand {
    static let configuration = CommandConfiguration(abstract: "Advent of Code - 2022 December 4", version: "1.0.0")

    // MARK: - Options

    @Option(name: .shortAndLong, help: "Input file path")
    var path: String = "../input/day04.txt"

    // MARK: - Lifecycle

    mutating func run() throws {
        try part1()
        try part2()
    }

    private func part1() throws {
        let sum = try String(contentsOfFile: path)
            .components(separatedBy: .newlines)
            .compactMap(makeSectionPair(withFormat:))
            .filter { $0.0.hasContainment(withRange: $0.1) }
            .count
        print("Contained sections (part 1): \(sum)")
    }

    private func part2() throws {
        let sum = try String(contentsOfFile: path)
            .components(separatedBy: .newlines)
            .compactMap(makeSectionPair(withFormat:))
            .filter { $0.0.overlaps($0.1) }
            .count
        print("Overlapped sections (part 2): \(sum)")
    }

    // MARK: - Private methods

    func makeRange(withFormat format: String) -> ClosedRange<Int>? {
        let range = format.components(separatedBy: "-").compactMap(Int.init)
        guard range.count == 2 else { return nil }
        return range[0] ... range[1]
    }

    private func makeSectionPair(withFormat format: String) -> (ClosedRange<Int>, ClosedRange<Int>)? {
        let sections = format.components(separatedBy: ",").compactMap(makeRange(withFormat:))
        return sections.count == 2 ? (sections[0], sections[1]) : nil
    }
}