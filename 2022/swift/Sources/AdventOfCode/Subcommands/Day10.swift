import ArgumentParser
import Foundation

struct Day10: ParsableCommand {
    static let configuration = CommandConfiguration(abstract: "Advent of Code - 2022 December 10", version: "1.0.0")

    // MARK - Data structures

    struct CycleInstruction {
        var cycles: Int
        let value: Int

        init?(_ rawValue: String) {
            let components = rawValue.components(separatedBy: .whitespaces)
            switch components[0].lowercased() {
            case "noop":
                self.cycles = 1
                self.value = 0
            case "addx":
                self.cycles = 2
                self.value = components.count == 2 ? Int(components[1]) ?? 0 : 0
            default:
                return nil
            }
        }
    }

    // MARK: - Options

    @Option(name: .shortAndLong, help: "Input file path")
    var path: String = "../input/day10.txt"

    // MARK: - Lifecycle

    mutating func run() throws {
        let instructions = makeInstructions(fromString: try String(contentsOfFile: path))
        let (part1, part2) = solve(instructions: instructions)
        print("Part 1:\n\(part1)\n")
        print("Part 2:\n\(part2)")
    }

    // MARK: - Internal methods

    func makeInstructions(fromString str: String) -> [CycleInstruction] {
        str.components(separatedBy: .newlines).compactMap(CycleInstruction.init)
    }

    func solve(instructions: [CycleInstruction]) -> (Int, String) {
        var ins = instructions
        var (cycle, pixels, pos, x, sum) = (1, "", 0, 1, 0)

        while ins.count > 0 {
            if (cycle - 20) % 40 == 0 {
                sum += x * cycle
            }

            // Draw the pixel
            pixels += x-1...x+1 ~= pos ? "#" : "."
            pos += 1

            // Reset position if this is end of the CRT's draw distance
            if pos % 40 == 0 {
                pixels += "\n"
                pos = 0
            }

            // Apply instructions to move the register
            ins[0].cycles -= 1

            if ins[0].cycles <= 0 {
                x += ins[0].value
                ins.removeFirst()
            }
            cycle += 1
        }
        return (sum, pixels)
    }
}