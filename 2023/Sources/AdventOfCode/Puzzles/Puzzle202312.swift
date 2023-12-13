import Algorithms
import Collections
import Foundation

struct Puzzle202312: Puzzle {
  let input: [String]

  init(input: String) {
    self.input = input.lines
  }

  // MARK: - Public methods

  func solve1() throws -> Any {
    input.compactMap(arrangementCount).reduce(0, +)
  }

  func solve2() throws -> Any {
    return -1
  }

  // MARK: - Private methods

  private func arrangementCount(for input: String) -> Int? {
    let components = input.split(separator: " ")
    guard components.count == 2 else { return nil }
    return arrangementCount(for: String(components[0]), sizes: components[1].integerValues)
  }

  private func arrangementCount(for record: String, sizes: [Int]) -> Int {
    guard !record.isEmpty else { return sizes.isEmpty ? 1 : 0 }
    guard !sizes.isEmpty else { return record.contains("#") ? 0 : 1 }
    var count = 0

    if ".?".contains(record[0]) {
      count += arrangementCount(for: String(record.dropFirst()), sizes: sizes)
    }
    let size = sizes[0]

    if "#?".contains(record[0]) && size <= record.count
      && !record.prefix(size).contains(".")
      && (size == record.count || record[size] != "#")
    {
      count += arrangementCount(
        for: String(record.dropFirst(sizes[0] + 1)), sizes: Array(sizes.dropFirst()))
    }
    return count
  }
}
