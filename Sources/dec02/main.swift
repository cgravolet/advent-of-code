//
//  main.swift
//  
//
//  Created by Gravolet, Charles on 12/1/22.
//

import ArgumentParser
import Foundation

struct AdventDay02: ParsableCommand {
    static let configuration = CommandConfiguration(abstract: "Advent of Code - 2022 December 2", version: "1.0.0")

    @Option(name: .shortAndLong, help: "Input file path")
    var path: String = "input/dec02.txt"

    mutating func run() throws {
        print("Hello, Advent of Code Day 2!")
    }
}

AdventDay02.main()
