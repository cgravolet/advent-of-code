import ArgumentParser
import Foundation

struct Adventofcode: ParsableCommand {
    static let configuration = CommandConfiguration(abstract: "Advent of Code 2022", subcommands: [
        Day01.self, Day02.self, Day03.self, Day04.self, Day05.self, Day06.self
    ])

    init() {}
}

Adventofcode.main()