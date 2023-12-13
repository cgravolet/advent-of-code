import Algorithms
import Collections
import Foundation

private struct SpringCondition: Hashable {
  let record: String
  let sizes: [Int]
}

struct Puzzle202312: Puzzle {
  let input: [String]

  init(input: String) {
    self.input = input.lines
  }

  // MARK: - Public methods

  func solve1() throws -> Any {
    var cache = [SpringCondition: Int]()
    return input.reduce(0, { $0 + arrangementCount(for: $1, cache: &cache) })
  }

  func solve2() throws -> Any {
    var cache = [SpringCondition: Int]()
    return input.reduce(0, { $0 + arrangementCount(for: unfold($1), cache: &cache) })
  }

  // MARK: - Private methods

  private func arrangementCount(for input: String, cache: inout [SpringCondition: Int]) -> Int {
    let components = input.split(separator: " ")
    guard components.count == 2 else { return 0 }
    return arrangementCount(
      for: String(components[0]), sizes: components[1].integerValues, cache: &cache)
  }

  private func arrangementCount(
    for record: String, sizes: [Int], cache: inout [SpringCondition: Int]
  ) -> Int {
    guard !record.isEmpty else { return sizes.isEmpty ? 1 : 0 }
    guard !sizes.isEmpty else { return record.contains("#") ? 0 : 1 }
    let key = SpringCondition(record: record, sizes: sizes)

    if let count = cache[key] {
      return count
    }
    var count = 0

    if ".?".contains(record[0]) {
      count += arrangementCount(for: String(record.dropFirst()), sizes: sizes, cache: &cache)
    }
    let size = sizes[0]

    if "#?".contains(record[0]) && size <= record.count
      && !record.prefix(size).contains(".")
      && (size == record.count || record[size] != "#")
    {
      count += arrangementCount(
        for: String(record.dropFirst(sizes[0] + 1)), sizes: Array(sizes.dropFirst()), cache: &cache)
    }
    cache[key] = count
    return count
  }

  private func unfold(_ input: String) -> String {
    input
      .split(separator: " ")
      .enumerated()
      .map {
        Array(repeating: $0.element, count: 5).joined(separator: $0.offset == 0 ? "?" : ",")
      }
      .joined(separator: " ")
  }
}
