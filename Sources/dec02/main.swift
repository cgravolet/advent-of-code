//
//  main.swift
//  
//
//  Created by Gravolet, Charles on 12/1/22.
//

import ArgumentParser
import Foundation

enum Shape: Int {
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

    func score(shape: Shape) -> Int {
        let (win, lose, draw) = (6, 0, 3)
        var score = shape.rawValue

        switch (self, shape) {
        case (.rock, .rock): score += draw
        case (.rock, .paper): score += win
        case (.rock, .scissors): score += lose
        case (.paper, .rock): score += lose
        case (.paper, .paper): score += draw
        case (.paper, .scissors): score += win
        case (.scissors, .rock): score += win
        case (.scissors, .paper): score += lose
        case (.scissors, .scissors): score += draw
        }
        return score
    }
}

struct AdventDay02: ParsableCommand {
    static let configuration = CommandConfiguration(abstract: "Advent of Code - 2022 December 2", version: "1.0.0")

    @Option(name: .shortAndLong, help: "Input file path")
    var path: String = "input/dec02.txt"

    mutating func run() throws {
        let totalScore = try String(contentsOfFile: path)
            .components(separatedBy: .newlines)
            .compactMap { line -> (Shape, Shape)? in
                let shapes = line.components(separatedBy: " ").compactMap { Shape($0) }
                return shapes.count == 2 ? (shapes[0], shapes[1]) : nil
            }
            .map { $0.0.score(shape: $0.1) }
            .reduce(0, +)
        print("Total Score: \(totalScore)")
    }
}

AdventDay02.main()
