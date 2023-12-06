import Foundation
import RegexBuilder

extension String {
  var integerValue: Int {
    Int(self.replacingOccurrences(of: "[^0-9]+", with: "", options: .regularExpression)) ?? 0
  }

  var integerValues: [Int] {
    matches(of: /(\d+)/).compactMap { Int($0.output.1) }
  }

  var lines: [String] {
    trimmingCharacters(in: .whitespacesAndNewlines).components(separatedBy: .newlines)
  }

  subscript(i: Int) -> Character {
    self[index(startIndex, offsetBy: i)]
  }
}

extension Substring {
  var integerValue: Int { String(self).integerValue }
  var integerValues: [Int] { String(self).integerValues }
}
