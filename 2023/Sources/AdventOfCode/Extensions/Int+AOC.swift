import Foundation

extension Int {
  func toString() -> String {
    return String(format: "%d", self)
  }
}

// Calculates the greatest common divisor of two numbers
func gcd(_ a: Int, _ b: Int) -> Int {
  let r = a % b
  return r != 0 ? gcd(b, r) : b
}

// Calculates the least common multiple of two numbers
func lcm(_ x: Int, _ y: Int) -> Int {
  x / gcd(x, y) * y
}
