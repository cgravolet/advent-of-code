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
