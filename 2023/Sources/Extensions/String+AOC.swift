import Foundation

extension String {
  func toInt() -> Int {
    Int(self.replacingOccurrences(of: "[^0-9]+", with: "", options: .regularExpression)) ?? 0
  }

  subscript(i: Int) -> Character {
    self[index(startIndex, offsetBy: i)]
  }
}
