import Foundation

struct CamelCardHand {
  let bid: Int
  let isJokers: Bool
  let rawValue: String
  let strength: CamelCardHandStrength

  init(rawValue: String, bid: Int, isJokers: Bool = false) {
    self.bid = bid
    self.isJokers = isJokers
    self.rawValue = rawValue
    self.strength = CamelCardHandStrength(rawValue: rawValue, isJokers: isJokers)
  }
}

extension CamelCardHand: Comparable {
  private static let cardRanks: [String: Int] = [
    "A": 12, "K": 11, "Q": 10, "J": 9, "T": 8, "9": 7, "8": 6, "7": 5, "6": 4, "5": 3, "4": 2,
    "3": 1, "2": 0,
  ]
  private static let cardRanksJoker: [String: Int] = [
    "A": 12, "K": 11, "Q": 10, "T": 9, "9": 8, "8": 7, "7": 6, "6": 5, "5": 4, "4": 3, "3": 2,
    "2": 1, "J": 0,
  ]
  private static let strengthRanks: [CamelCardHandStrength: Int] = [
    .fiveOfAKind: 6, .fourOfAKind: 5, .fullHouse: 4, .threeOfAKind: 3, .twoPair: 2, .onePair: 1,
    .highCard: 0,
  ]

  static func < (lhs: CamelCardHand, rhs: CamelCardHand) -> Bool {
    let lhStrength = Self.strengthRanks[lhs.strength]!
    let rhStrength = Self.strengthRanks[rhs.strength]!

    if lhStrength != rhStrength {
      return lhStrength < rhStrength
    }

    for (index, lhsChar) in lhs.rawValue.enumerated() {
      let rhsChar = rhs.rawValue[index]

      if lhsChar != rhsChar {
        let lhsRank =
          lhs.isJokers ? Self.cardRanksJoker[String(lhsChar)]! : Self.cardRanks[String(lhsChar)]!
        let rhsRank =
          rhs.isJokers ? Self.cardRanksJoker[String(rhsChar)]! : Self.cardRanks[String(rhsChar)]!
        return lhsRank < rhsRank
      }
    }
    return lhs.rawValue < rhs.rawValue
  }
}
