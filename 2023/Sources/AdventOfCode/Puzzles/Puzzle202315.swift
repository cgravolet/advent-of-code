import Algorithms
import Collections
import Foundation

struct Step {
  let box: Int
  let label: String
  let command: String
  let lens: Int?
}

struct Puzzle202315: Puzzle {
  let input: String

  // MARK: - Public methods

  func solve1() throws -> Any {
    input
      .trimmingCharacters(in: .whitespacesAndNewlines)
      .split(separator: ",")
      .reduce(0, hashInto)
  }

  func solve2() throws -> Any {
    var boxes = [OrderedDictionary<String, Int>](repeating: OrderedDictionary<String, Int>(), count: 256)

    input
      .trimmingCharacters(in: .whitespacesAndNewlines)
      .split(separator: ",")
      .compactMap(parseStep)
      .forEach { performStep($0, boxes: &boxes) }

    return focusPower(of: boxes)
  }

  // MARK: - Private methods

  private func focusPower(of boxes: [OrderedDictionary<String, Int>]) -> Int {
    var power = 0

    for (index, box) in boxes.enumerated() where !box.isEmpty {
      for (slot, lens) in box.elements.enumerated() {
        let lensPower = (index + 1) * (slot + 1) * lens.value
        power += lensPower
      }
    }
    return power
  }

  private func hash(_ input: String) -> Int {
    var cur = 0
    for char in input {
      if let asciiValue = char.asciiValue {
        cur = (cur + Int(asciiValue)) * 17 % 256
      }
    }
    return cur
  }

  private func hashInto(_ value: Int, _ input: Substring) -> Int {
    value + hash(String(input))
  }

  private func parseStep(_ input: Substring) -> Step? {
    guard let match = input.firstMatch(of: /([A-Za-z]+)([=-])([0-9]+)?/) else { return nil }
    var lens: Int?
    if let lensMatch = match.output.3 {
      lens = Int(lensMatch)
    }
    let label = String(match.output.1)
    return Step(
      box: hash(label),
      label: label,
      command: String(match.output.2),
      lens: lens
    )
  }

  private func performStep(_ step: Step, boxes: inout [OrderedDictionary<String, Int>]) {
    if step.command == "-" {
      boxes[step.box].removeValue(forKey: step.label)
    } else if let lens = step.lens {
      boxes[step.box][step.label] = lens
    }
  }
}
