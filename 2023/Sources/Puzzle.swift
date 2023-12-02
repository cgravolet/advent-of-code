@_exported import Algorithms
@_exported import Collections
import Foundation

protocol Puzzle {
  init(input: String)

  func solve1() throws -> Any

  func solve2() throws -> Any
}

extension Puzzle {
  static var day: Int {
    let typeName = String(reflecting: Self.self)
    guard let i = typeName.lastIndex(where: { !$0.isNumber })  ,
      let day = Int(typeName[i...].dropFirst())
    else {
      fatalError("""
      Day number not found in type name: \
      implement the static `day` property \
      or use the day number as your type's suffix (like `202303`).")
      """)
    }
    return day
  }

  var day: Int { Self.day }

  init() {
    var fileName = String(format: "%d.txt", Self.day)
    fileName.insert("-", at: fileName.index(fileName.startIndex, offsetBy: 4))
    do {
      let data = try String(contentsOfFile: "../input/\(fileName)")
      self.init(input: data)
    } catch {
      fatalError(error.localizedDescription)
    }
  }

  func solve1() throws -> Any {
    "Not implemented"
  }

  func solve2() throws -> Any {
    "Not implemented"
  }
}