import Algorithms
import Collections
import Foundation

private struct MachinePart {
  let a: Int
  let m: Int
  let s: Int
  let x: Int
}

struct Puzzle202319: Puzzle {
  let input: String

  // MARK: - Public methods

  func solve1() throws -> Any {
    let (workflows, parts) = parseInput(input)
    return parts
      .filter { isPartAccepted($0, workflows: workflows) }
      .reduce(0, { $0 + $1.a + $1.m + $1.s + $1.x })
  }

  func solve2() throws -> Any {
    return -1
  }

  // MARK: - Private methods

  private func evaluate(_ part: MachinePart, workflow: String) -> String {
    for condition in workflow.split(separator: ",") {
      if let match = condition.firstMatch(of: /([amsx])([<>])([0-9]+):([RAa-z]+)/), let rhs = Int(match.output.3) {
        let lhs: Int
        switch String(match.output.1) {
        case "a": lhs = part.a
        case "m": lhs = part.m
        case "s": lhs = part.s
        case "x": lhs = part.x
        default: continue
        }
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

  private func isPartAccepted(_ part: MachinePart, workflows: [String: String]) -> Bool {
    var workflow = workflows["in"]
    while workflow != nil {
      let value = evaluate(part, workflow: workflow!)
      switch value {
      case "R": return false
      case "A": return true
      default: workflow = workflows[value]
      }
    }
    return false
  }

  private func parseInput(_ input: String) -> (workflows: [String: String], [MachinePart]) {
    let components = input.split(separator: "\n\n")
    guard components.count == 2 else { return ([String: String](), []) }
    let workflows = String(components[0]).lines.reduce(
      into: [String: String](),
      {
        if let match = $1.firstMatch(of: /([a-z]+){([^}]+)}/) {
          $0[String(match.output.1)] = String(match.output.2)
        }
      })
    let parts = String(components[1]).lines.reduce(
      into: [MachinePart](),
      {
        if let match = $1.firstMatch(of: /{x=([0-9]+),m=([0-9]+),a=([0-9]+),s=([0-9]+)}/),
          let x = Int(match.output.1), let m = Int(match.output.2), let a = Int(match.output.3),
          let s = Int(match.output.4)
        {
          $0.append(MachinePart(a: a, m: m, s: s, x: x))
        }
      })
    return (workflows, parts)
  }
}
