import Foundation

extension Decimal {
  var fraction: Decimal { self - whole }
  var intValue: Int { (whole as NSDecimalNumber).intValue }
  var whole: Decimal { rounded(sign == .minus ? .up : .down) }

  func rounded(_ roundingMode: NSDecimalNumber.RoundingMode = .plain) -> Decimal {
    var result = Decimal()
    var number = self
    NSDecimalRound(&result, &number, 0, roundingMode)
    return result
  }
}
