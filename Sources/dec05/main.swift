import ArgumentParser
import Foundation

protocol Mover {
    var stacks: [[String]] { get }
    mutating func run(_: [Instruction]) -> String
}

extension Mover {
    var topRow: String {
        stacks.compactMap(\.last).joined()
    }
}

struct CrateMover9000: Mover {
    var stacks: [[String]]

    mutating func run(_ instructions: [Instruction]) -> String {
        for instruction in instructions {
            for _ in 0..<instruction.count {
                if let crate = stacks[instruction.from].popLast() {
                    stacks[instruction.to].append(crate)
                }
            }
        }
        return topRow
    }
}

struct CrateMover9001: Mover {
    var stacks: [[String]]

    mutating func run(_ instructions: [Instruction]) -> String {
        for instruction in instructions {
            var crates = [String]()
            for _ in 0..<instruction.count {
                if let crate = stacks[instruction.from].popLast() {
                    crates.insert(crate, at: 0)
                }
            }
            stacks[instruction.to].append(contentsOf: crates)
        }
        return topRow
    }
}

struct Instruction {
    let count: Int
    let from: Int
    let to: Int
}

struct InstructionParser {
    static func parse(_ input: String) throws -> ([[String]], [Instruction]) {
        var stacks = Array(repeating: [String](), count: 9)
        var instructions = [Instruction]()

        for line in input.components(separatedBy: .newlines) {
            if let row = try parseStack(fromLine: line) {
                for (i, crate) in row.enumerated() {
                    if let crate = crate {
                        stacks[i].insert(crate, at: 0)
                    }
                }
            } else if let instruction = try parseInstruction(fromLine: line) {
                instructions.append(instruction)
            }
        }
        return (stacks, instructions)
    }

    private static func parseInstruction(fromLine line: String) throws -> Instruction? {
        var instruction: Instruction?
        let pattern = "^move ([0-9]+) from ([0-9]+) to ([0-9]+)$"
        let regex = try NSRegularExpression(pattern: pattern)
        let range = NSRange(line.startIndex..<line.endIndex, in: line)
        regex.enumerateMatches(in: line, options: [], range: range) { match, _, stop in
            guard let match = match, match.numberOfRanges == 4,
                  let countRange = Range(match.range(at: 1), in: line),
                  let fromRange = Range(match.range(at: 2), in: line),
                  let toRange = Range(match.range(at: 3), in: line),
                  let count = Int(line[countRange]),
                  let from = Int(line[fromRange]),
                  let to = Int(line[toRange])
            else { return }
            instruction = Instruction(count: count, from: from - 1, to: to - 1)
            stop.pointee = true
        }
        return instruction
    }

    private static func parseStack(fromLine line: String) throws -> [String?]? {
        guard line.contains("[") else { return nil }
        var stack = [String?]()
        let pattern = "\\[([A-Za-z]+)\\]"
        let regex = try NSRegularExpression(pattern: pattern)
        let range = NSRange(line.startIndex..<line.endIndex, in: line)
        regex.enumerateMatches(in: line, options: [], range: range) { match, _, _ in
            guard let match = match, match.numberOfRanges == 2,
                  let crateRange = Range(match.range(at: 1), in: line)
            else { return }
            let crate = String(line[crateRange])
            let index = (line.distance(from: line.startIndex, to: crateRange.lowerBound) - 1) / 4
            while stack.count <= index {
                stack.append(nil)
            }
            stack[index] = crate
        }
        return stack
    }
}

struct AdventDay05: ParsableCommand {
    static let configuration = CommandConfiguration(abstract: "Advent of Code - 2022 December 5", version: "1.0.0")

    // MARK: - Options

    @Option(name: .shortAndLong, help: "Input file path")
    var path: String = "input/dec05.txt"

    // MARK: - Lifecycle

    mutating func run() throws {
        let (stacks, instructions) = try InstructionParser.parse(try String(contentsOfFile: path))
        var mover9000 = CrateMover9000(stacks: stacks)
        var mover9001 = CrateMover9001(stacks: stacks)
        print("Day 5 answer (part 1): \(mover9000.run(instructions))")
        print("Day 5 answer (part 2): \(mover9001.run(instructions))")
    }
}

AdventDay05.main()
