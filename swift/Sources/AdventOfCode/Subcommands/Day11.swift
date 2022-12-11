import ArgumentParser
import Foundation

struct Day11: ParsableCommand {
    static let configuration = CommandConfiguration(abstract: "Advent of Code - 2022 December 10", version: "1.0.0")

    // MARK - Data structures

    typealias MonkeyBusiness = Int
    typealias MonkeyIndex = Int
    typealias WorryLevel = Int

    struct Monkey {
        let indexFalse: MonkeyIndex
        let indexTrue: MonkeyIndex
        var inspections: Int
        var inventory: [WorryLevel]
        let operation: (WorryLevel) -> WorryLevel
        let quotient: Int

        init(indexFalse: MonkeyIndex, indexTrue: MonkeyIndex, inspections: Int = 0, inventory: [WorryLevel],
             operation: @escaping (WorryLevel) -> WorryLevel, quotient: Int) {
            self.indexFalse = indexFalse
            self.indexTrue = indexTrue
            self.inspections = inspections
            self.inventory = inventory
            self.operation = operation
            self.quotient = quotient
        }

        mutating func inspect(_ wl: WorryLevel) -> WorryLevel {
            let worry = operation(wl) / 3
            inspections += 1
            return worry
        }

        func test(_ worry: WorryLevel) -> MonkeyIndex {
            worry % quotient == 0 ? indexTrue : indexFalse
        }
    }

    // MARK: - Options

    @Option(name: .shortAndLong, help: "Input file path")
    var path: String = "../input/day11.txt"

    // MARK: - Lifecycle

    mutating func run() throws {
        let monkeys = try observeMonkeys(notes: try String(contentsOfFile: path))
        let part1 = solvePart1(monkeys: monkeys)
        print("Part 1: \(part1)")
    }

    func solvePart1(monkeys: [Monkey]) -> MonkeyBusiness {
        var monkeys = monkeys
        for _ in 0 ..< 20 {
            monkeys = performRound(monkeys: monkeys)
        }
        return calculateMonkeyBusiness(monkeys: monkeys)
    }

    // MARK: - Internal methods

    func calculateMonkeyBusiness(monkeys: [Monkey]) -> MonkeyBusiness {
        let monkeys = monkeys.sorted { $0.inspections > $1.inspections }
        guard monkeys.count > 1 else { return 0 }
        return monkeys[0].inspections * monkeys[1].inspections
    }

    func observeMonkeys(notes: String) throws -> [Monkey] {
        let pattern = #"Monkey \d+:\s+Starting items: ([0-9, ]+)\s+Operation: new = old ([+*]+) ([A-Za-z0-9]+)\s+Test: divisible by (\d+)\s+If true:[^0-9]+(\d+)\s+If false:[^0-9]+(\d+)\s*"#
        let regex = try NSRegularExpression(pattern: pattern)
        let matches = regex.matches(in: notes, range: NSRange(notes.startIndex..<notes.endIndex, in: notes))
        return matches.compactMap { makeMonkey(fromResult:$0, notes: notes) }
    }

    func performRound(monkeys: [Monkey]) -> [Monkey] {
        var mutableMonkeys = monkeys

        for m in 0 ..< mutableMonkeys.count {
            while mutableMonkeys[m].inventory.count > 0 {
                let worry = mutableMonkeys[m].inspect(mutableMonkeys[m].inventory.removeFirst())
                mutableMonkeys[mutableMonkeys[m].test(worry)].inventory.append(worry)
            }
        }
        return mutableMonkeys
    }

    // MARK: - Private methods

    private func makeMonkey(fromResult match: NSTextCheckingResult, notes: String) -> Monkey? {
        guard match.numberOfRanges == 7,
              let group1 = Range(match.range(at: 1), in: notes),
              let group2 = Range(match.range(at: 2), in: notes),
              let group3 = Range(match.range(at: 3), in: notes),
              let group4 = Range(match.range(at: 4), in: notes),
              let group5 = Range(match.range(at: 5), in: notes),
              let group6 = Range(match.range(at: 6), in: notes),
              let quotient = Int(notes[group4]),
              let indexTrue = Int(notes[group5]),
              let indexFalse = Int(notes[group6])
        else { return nil }
        let inventory = notes[group1].components(separatedBy: ", ").compactMap(Int.init)
        let operationStr = notes[group2]
        let operationRhsStr = notes[group3]
        return Monkey(indexFalse: indexFalse, indexTrue: indexTrue, inventory: inventory,
                      operation: { wl -> WorryLevel in
            let rhs = WorryLevel(operationRhsStr) ?? wl
            switch operationStr {
            case "*": return wl * rhs
            case "+": return wl + rhs
            default: return wl
            }
        }, quotient: quotient)
    }
}