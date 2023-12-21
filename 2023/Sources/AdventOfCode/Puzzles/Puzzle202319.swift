import Algorithms
import Collections
import Foundation

struct Puzzle202319: Puzzle {
  typealias MachinePart = [String: Int]

  let input: String

  // MARK: - Public methods

  func solve1() throws -> Any {
    let (workflows, parts) = parseInput(input)
    return
      parts
      .filter { isPartAccepted($0, workflows: workflows) }
      .reduce(0, { $0 + $1.values.reduce(0, +) })
  }

  func solve2() throws -> Any {
    let (workflows, _) = parseInput(input)
    let ranges = ["x": (1, 4_000), "m": (1, 4_000), "a": (1, 4_000), "s": (1, 4_000)]
    return combinations(of: ranges, in: workflows)
  }

  // MARK: - Private methods

  private func evaluate(_ part: MachinePart, workflow: String) -> String {
    for condition in workflow.split(separator: ",") {
      if let match = condition.firstMatch(of: /([amsx])([<>])([0-9]+):([RAa-z]+)/),
        let rhs = Int(match.output.3)
      {
        guard let lhs = part[String(match.output.1)] else { continue }

        switch String(match.output.2) {
        case "<" where lhs < rhs:
          return String(match.output.4)
        case ">" where lhs > rhs:
          return String(match.output.4)
        default: continue
        }
      } else if let match = condition.firstMatch(of: /([ARa-z]+)/) {
        return String(match.output.1)
      }
    }
    return "R"
  }

  private func isPartAccepted(_ part: MachinePart, workflows: [String: String], key: String = "in")
    -> Bool
  {
    guard let workflow = workflows[key] else { return false }
    let value = evaluate(part, workflow: workflow)
    switch value {
    case "R": return false
    case "A": return true
    default: return isPartAccepted(part, workflows: workflows, key: value)
    }
  }

  private func parseInput(_ input: String) -> (workflows: [String: String], parts: [[String: Int]])
  {
    let components = input.split(separator: "\n\n").map(String.init)

    guard components.count == 2 else {
      return ([:], [])
    }

    let workflows = components[0].lines.reduce(
      into: [String: String](),
      {
        if let match = $1.firstMatch(of: /([a-z]+){([^}]+)}/) {
          $0[String(match.output.1)] = String(match.output.2)
        }
      })

    let parts = components[1].lines.reduce(
      into: [[String: Int]](),
      {
        $0.append(
          $1.matches(of: /([xmas])=([0-9]+)/).reduce(
            into: [String: Int](),
            {
              $0[String($1.output.1)] = Int($1.output.2)
            })
        )
      })

    return (workflows, parts)
  }

  private func combinations(
    of ranges: [String: (Int, Int)], in workflows: [String: String], at flow: String = "in"
  ) -> Int {
    guard flow != "R" else { return 0 }
    guard flow != "A" else { return ranges.reduce(1, { $0 * ($1.value.1 - $1.value.0 + 1) }) }
    guard let workflow = workflows[flow] else { return 0 }

    var mutableRanges = ranges
    var value = 0

    for condition in workflow.split(separator: ",") {
      if let match = condition.firstMatch(of: /([amsx])([<>])([0-9]+):([RAa-z]+)/),
        let rhs = Int(match.output.3)
      {
        let lhsKey = String(match.output.1)
        let op = String(match.output.2)

        guard let lhs = mutableRanges[lhsKey] else { continue }
        let passRange: (Int, Int)
        let failRange: (Int, Int)

        switch op {
        case ">":
          passRange = (rhs + 1, lhs.1)
          failRange = (lhs.0, rhs)
        case "<":
          passRange = (lhs.0, rhs - 1)
          failRange = (rhs, lhs.1)
        default:
          continue
        }

        if passRange.0 <= passRange.1 {
          var nextRanges = mutableRanges
          nextRanges[lhsKey] = passRange
          value += combinations(of: nextRanges, in: workflows, at: String(match.output.4))
        }

        if failRange.0 <= failRange.1 {
          mutableRanges[lhsKey] = failRange
        }

      } else if let match = condition.firstMatch(of: /([ARa-z]+)/) {
        value += combinations(of: mutableRanges, in: workflows, at: String(match.output.1))
      }
    }
    return value
  }
}
