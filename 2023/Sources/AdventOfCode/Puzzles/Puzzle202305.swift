import Algorithms
import Collections
import Foundation

struct Puzzle202305: Puzzle {
  let input: [String]

  init(input: String) {
    self.input = input.split(separator: "\n\n").map { String($0) }
  }

  // MARK: - Public methods

  func solve1() throws -> Any {
    let (seeds, almanac) = parseAlmanac(from: input, parseSeeds1)
    return try seeds.map({ try getLocation(of: $0, category: .seed, in: almanac) }).min() ?? -1
  }

  func solve2() throws -> Any {
    let (seeds, almanac) = parseAlmanac(from: input, parseSeeds2)
    return try seeds.map({ try getLocation(of: $0, category: .seed, in: almanac) }).min() ?? -1
  }

  // MARK: - Private methods

  private func getLocation(of value: Int, category: GardenMap.Category, in almanac: [GardenMap])
    throws -> Int
  {
    guard category != .location else { return value }

    guard let map = almanac.first(where: { $0.category.source == category }) else {
      throw AOCError("Could not find map for source: \(category)")
    }
    let location: Int

    if let mapRange = map.ranges.first(where: { $0.source ~= value }) {
      let delta = value - (mapRange.source.first ?? 0)
      location = (mapRange.destination.first ?? 0) + delta
    } else {
      location = value
    }
    return try getLocation(of: location, category: map.category.destination, in: almanac)
  }

  private func parseAlmanac(from input: [String], _ parseSeeds: (String) -> [Int]) -> (
    [Int], [GardenMap]
  ) {
    (parseSeeds(input.first ?? ""), input[1..<input.count].compactMap(parseMap))
  }

  /// Parses a garden map from the given input (i.e. "seed-to-soil map:\n50 98 2\n52 50 48")
  private func parseMap(from input: String) -> GardenMap? {
    let components = input.split(separator: ":")
    guard let catMatch = components.first?.firstMatch(of: /([A-Za-z]+)\-to\-([A-Za-z]+)/),
      let src = GardenMap.Category(rawValue: String(catMatch.output.1)),
      let dest = GardenMap.Category(rawValue: String(catMatch.output.2))
    else { return nil }
    return GardenMap(
      source: src,
      destination: dest,
      ranges: components.last?.split(separator: "\n").compactMap(parseRange) ?? []
    )
  }

  /// Parses a range from the given input (i.e. "50 98 2")
  private func parseRange(from input: Substring) -> (Range<Int>, Range<Int>)? {
    input.firstMatch(of: /(\d+)\s+(\d+)\s+(\d+)/)
      .map {
        (
          dest: $0.output.1.integerValue, src: $0.output.2.integerValue,
          len: $0.output.3.integerValue
        )
      }
      .map { ($0.src..<$0.src + $0.len, $0.dest..<$0.dest + $0.len) }
  }

  /// Parses an array of seed values from the given input (i.e. "79 14 55 13")
  private func parseSeeds1(from input: String) -> [Int] {
    input.integerValues
  }

  /// Parses an array of seed values from the given input (i.e. "79 14 55 13")
  private func parseSeeds2(from input: String) -> [Int] {
    input.integerValues.chunks(ofCount: 2)
      .map { $0.first!..<$0.first! + $0.last! }
      .flatMap { [Int]($0) }
  }
}
