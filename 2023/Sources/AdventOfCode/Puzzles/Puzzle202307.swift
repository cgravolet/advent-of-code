import Algorithms
import Collections
import Foundation

struct CamelCardHand: Comparable {
  static let cardRanks: [String: Int] = [
    "A": 12, "K": 11, "Q": 10, "J": 9, "T": 8, "9": 7, "8": 6, "7": 5, "6": 4, "5": 3, "4": 2, "3": 1, "2": 0
  ]
  static let categoryRanks: [Category: Int] = [
    .fiveOfAKind: 6, .fourOfAKind: 5, .fullHouse: 4, .threeOfAKind: 3, .twoPair: 2, .onePair: 1, .highCard: 0,
  ]

  enum Category: CaseIterable {
    case fiveOfAKind, fourOfAKind, fullHouse, threeOfAKind, twoPair, onePair, highCard

    init(rawValue: String) {
      let value = rawValue.sorted().map(String.init).joined()
      var runs = [Int]()
      var prev: Character?
      var currentRun = 1

      for char in value {
        if char == prev {
          currentRun += 1
        } else if currentRun > 1 {
          runs.append(currentRun)
          currentRun = 1
        }
        prev = char
      }

      if currentRun > 1 {
        runs.append(currentRun)
      }

      if runs.contains(5) {
        self = .fiveOfAKind
      } else if runs.contains(4) {
        self = .fourOfAKind
      } else if runs.contains(3) {
        self = runs.contains(2) ? .fullHouse : .threeOfAKind
      } else if runs.contains(2) {
        self = runs.filter { $0 == 2 }.count == 2 ? .twoPair : .onePair
      } else {
        self = .highCard
      }
    }
  }

  let rawValue: String
  let bid: Int
  let category: Category

  init(rawValue: String, bid: Int) {
    self.rawValue = rawValue
    self.bid = bid
    self.category = Category(rawValue: rawValue)
  }

  static func < (lhs: CamelCardHand, rhs: CamelCardHand) -> Bool {
    let lhsCatRank = Self.categoryRanks[lhs.category]!
    let rhsCatRank = Self.categoryRanks[rhs.category]!

    if lhsCatRank != rhsCatRank {
      return lhsCatRank < rhsCatRank
    }

    for (index, lhsChar) in lhs.rawValue.enumerated() {
      let rhsChar = rhs.rawValue[index]

      if lhsChar != rhsChar {
        let lhsRank = Self.cardRanks[String(lhsChar)]!
        let rhsRank = Self.cardRanks[String(rhsChar)]!
        return lhsRank < rhsRank
      }
    }
    return lhs.rawValue < rhs.rawValue
  }
}

struct Puzzle202307: Puzzle {
  let input: String

  // MARK: - Public methods

  func solve1() throws -> Any {
    input.lines
      .compactMap(card)
      .sorted(by: <)
      .enumerated()
      .map { ($0 + 1) * $1.bid }
      .reduce(0, +)
  }

  func solve2() throws -> Any {
    -1
  }

  // MARK: - Private methods

  /// Parses a CamelCardHand from the given String (e.g. "32T3K 765").
  private func card(from input: String) -> CamelCardHand? {
    let components = input.components(separatedBy: " ")
    guard components.count == 2 else { return nil }
    return CamelCardHand(rawValue: components[0], bid: Int(components[1]) ?? 0)
  }
}
