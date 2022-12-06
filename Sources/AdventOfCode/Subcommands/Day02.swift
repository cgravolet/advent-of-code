//
//  main.swift
//
//
//  Created by Gravolet, Charles on 12/1/22.
//

import ArgumentParser
import Foundation

enum Shape: Int, CaseIterable {
    case rock = 1
    case paper = 2
    case scissors = 3

    init?(_ stringValue: String) {
        switch stringValue.uppercased() {
        case "A", "X": self = .rock
        case "B", "Y": self = .paper
        case "C", "Z": self = .scissors
        default: return nil
        }
    }

    func play(shape: Shape) -> Outcome {
        switch (self, shape) {
        case (.rock, .rock): return .draw
        case (.rock, .paper): return .win
        case (.rock, .scissors): return .loss
        case (.paper, .rock): return .loss
        case (.paper, .paper): return .draw
        case (.paper, .scissors): return .win
        case (.scissors, .rock): return .win
        case (.scissors, .paper): return .loss
        case (.scissors, .scissors): return .draw
        }
    }

    func score(withOutcome outcome: Outcome) -> Int {
        guard let shape = Shape.allCases.first(where: { self.play(shape: $0) == outcome }) else { return 0 }
        return shape.rawValue + outcome.rawValue
    }

    func score(shape: Shape) -> Int {
        play(shape: shape).rawValue + shape.rawValue
    }
}

enum Outcome: Int {
    case draw = 3
    case win = 6
    case loss = 0

    init?(_ stringValue: String) {
        switch stringValue.uppercased() {
        case "X": self = .loss
        case "Y": self = .draw
        case "Z": self = .win
        default: return nil
        }
    }
}

struct Day02: ParsableCommand {
    static let configuration = CommandConfiguration(abstract: "Advent of Code - 2022 December 2", version: "1.0.0")

    // MARK: - Options

    @Option(name: .shortAndLong, help: "Input file path")
    var path: String = "input/day02.txt"

    // MARK: - Lifecycle

    mutating func run() throws {
        try part1()
        try part2()
    }

    // MARK: - Private methods

    private func part1() throws {
        let totalScore = try String(contentsOfFile: path)
            .components(separatedBy: .newlines)
            .compactMap { line -> (Shape, Shape)? in
                let shapes = line.components(separatedBy: " ").compactMap { Shape($0) }
                return shapes.count == 2 ? (shapes[0], shapes[1]) : nil
            }
            .reduce(0) { $0 + $1.0.score(shape: $1.1) }
        print("Total Score (part 1): \(totalScore)")
    }

    private func part2() throws {
        let totalScore = try String(contentsOfFile: path)
            .components(separatedBy: .newlines)
            .compactMap { line -> (Shape, Outcome)? in
                let inputs = line.components(separatedBy: " ")
                guard inputs.count == 2,
                      let shape = Shape(inputs[0]),
                      let outcome = Outcome(inputs[1])
                else { return nil }
                return (shape, outcome)
            }
            .reduce(0) { $0 + $1.0.score(withOutcome: $1.1) }
        print("Total Score (part 2): \(totalScore)")
    }
}