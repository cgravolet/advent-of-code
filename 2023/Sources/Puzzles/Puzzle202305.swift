import Algorithms
import Collections
import Foundation

struct GardenMap: CustomStringConvertible {
  enum Category: String {
    case seed, soil, fertilizer, water, light, temperature, humidity, location
  }
  let category: (source: Category, destination: Category)
  let ranges: [(source: Range<Int>, destination: Range<Int>)]

  init(source: Category, destination: Category, ranges: [(Range<Int>, Range<Int>)]) {
    self.category = (source: source, destination: destination)
    self.ranges = ranges
  }

  var description: String {
    "GardenMap(\(category.source.rawValue)-to-\(category.destination.rawValue),\(ranges))"
  }
}

struct Puzzle202305: Puzzle {
  let input: [String]

  init(input: String) {
    self.input = input.split(separator: "\n\n").map { String($0) }
  }

  // MARK: - Public methods

  func solve1() throws -> Any {
    let almanac = input[1..<input.count].compactMap(parseMap)
    let seeds = input.first?.integerValues
    return try seeds?.map({ try getLocation(of: $0, category: .seed, in: almanac) }).min() ?? -1
  }

  func solve2() throws -> Any {
    let almanac = input[1..<input.count].compactMap(parseMap)
    let seeds = parseSeeds(from: input.first ?? "")
    return try seeds.map({ try getLocation(of: $0, category: .seed, in: almanac) }).min() ?? -1
  }

  // MARK: - Private methods

  func getLocation(of value: Int, category: GardenMap.Category, in almanac: [GardenMap]) throws -> Int {
    guard category != .location else { return value }

    guard let map = almanac.first(where: { $0.category.source == category }) else {
      throw AOCError.custom("Could not find map for source \(category)")
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

  func parseMap(from input: String) -> GardenMap? {
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
  func parseRange(from input: Substring) -> (Range<Int>, Range<Int>)? {
    guard let match = input.firstMatch(of: /(\d+)\s+(\d+)\s+(\d+)/) else { return nil }
    let destStart = String(match.output.1).integerValue
    let srcStart = String(match.output.2).integerValue
    let length = String(match.output.3).integerValue
    return (srcStart..<srcStart + length, destStart..<destStart + length)
  }

  func parseSeeds(from input: String) -> [Int] {
    return input.integerValues.chunks(ofCount: 2)
      .map { $0.first!..<$0.first!+$0.last! }
      .flatMap { [Int]($0) }
  }
}
