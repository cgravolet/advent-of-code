import Algorithms
import Collections
import Foundation

struct CamelCardHand: Comparable {
  static let cardRanks: [String: Int] = [
    "A": 12, "K": 11, "Q": 10, "J": 9, "T": 8, "9": 7, "8": 6, "7": 5, "6": 4, "5": 3, "4": 2, "3": 1, "2": 0
  ]
  static let cardRanksJoker: [String: Int] = [
    "A": 12, "K": 11, "Q": 10, "T": 9, "9": 8, "8": 7, "7": 6, "6": 5, "5": 4, "4": 3, "3": 2, "2": 1, "J": 0
  ]
  static let categoryRanks: [Category: Int] = [
    .fiveOfAKind: 6, .fourOfAKind: 5, .fullHouse: 4, .threeOfAKind: 3, .twoPair: 2, .onePair: 1, .highCard: 0,
  ]

  enum Category: CaseIterable {
    case fiveOfAKind, fourOfAKind, fullHouse, threeOfAKind, twoPair, onePair, highCard

    static func getCategory(for rawValue: String) -> Category {
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
        return .fiveOfAKind
      } else if runs.contains(4) {
        return .fourOfAKind
      } else if runs.contains(3) {
        return runs.contains(2) ? .fullHouse : .threeOfAKind
      } else if runs.contains(2) {
        return runs.filter { $0 == 2 }.count == 2 ? .twoPair : .onePair
      }
      return .highCard
    }

    init(rawValue: String, isJokers: Bool = false) {
      let category = Self.getCategory(for: rawValue)

      guard isJokers && rawValue.contains("J") else {
        self = category
        return
      }
      let jokerCount = rawValue.filter({ $0 == "J" }).count

      switch category {
      case .fiveOfAKind:
        self = category
      case .fourOfAKind:
        self = .fiveOfAKind
      case .fullHouse:
        self = .fiveOfAKind
      case .threeOfAKind:
        self = .fourOfAKind
      case .twoPair:
        self = jokerCount == 1 ? .fullHouse : .fourOfAKind
      case .onePair:
        self = .threeOfAKind
      case .highCard:
        self = .onePair
      }
    }
  }

  let rawValue: String
  let bid: Int
  let category: Category
  let isJokers: Bool

  init(rawValue: String, bid: Int, isJokers: Bool = false) {
    self.rawValue = rawValue
    self.bid = bid
    self.isJokers = isJokers
    self.category = Category(rawValue: rawValue, isJokers: isJokers)
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
        let lhsRank = lhs.isJokers ? Self.cardRanksJoker[String(lhsChar)]! : Self.cardRanks[String(lhsChar)]!
        let rhsRank = rhs.isJokers ? Self.cardRanksJoker[String(rhsChar)]! : Self.cardRanks[String(rhsChar)]!
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
    solve(input, isJokers: false)
  }

  func solve2() throws -> Any {
    solve(input, isJokers: true)
  }

  // MARK: - Private methods

  /// Parses a CamelCardHand from the given String (e.g. "32T3K 765").
  func card(from input: String, isJokers: Bool = false) -> CamelCardHand? {
    let components = input.components(separatedBy: " ")
    guard components.count == 2 else { return nil }
    return CamelCardHand(rawValue: components[0], bid: Int(components[1]) ?? 0, isJokers: isJokers)
  }

  private func solve(_ input: String, isJokers: Bool) -> Int {
    input.lines
      .compactMap { card(from: $0, isJokers: isJokers) }
      .sorted(by: <)
      .enumerated()
      .map { ($0 + 1) * $1.bid }
      .reduce(0, +)
  }
}
