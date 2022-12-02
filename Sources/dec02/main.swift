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
        case "A": self = .rock
        case "B": self = .paper
        case "C": self = .scissors
        default: return nil
        }
    }

    func score(withOutcome outcome: Outcome) -> Int {
        guard let shape = Shape.allCases.first(where: { self.score(shape: $0) == outcome }) else { return 0 }
        return shape.rawValue + outcome.rawValue
    }

    func score(shape: Shape) -> Outcome {
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

struct AdventDay02: ParsableCommand {
    static let configuration = CommandConfiguration(abstract: "Advent of Code - 2022 December 2", version: "1.0.0")

    @Option(name: .shortAndLong, help: "Input file path")
    var path: String = "input/dec02.txt"

    mutating func run() throws {
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
            .map { $0.0.score(withOutcome: $0.1) }
            .reduce(0, +)
        print("Total Score: \(totalScore)")
    }
}

AdventDay02.main()
