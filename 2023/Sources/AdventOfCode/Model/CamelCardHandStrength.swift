import Foundation

enum CamelCardHandStrength {
  case fiveOfAKind, fourOfAKind, fullHouse, threeOfAKind, twoPair, onePair, highCard

  static func strength(for rawValue: String) -> CamelCardHandStrength {
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
      return runs.filter({ $0 == 2 }).count == 2 ? .twoPair : .onePair
    }
    return .highCard
  }

  init(rawValue: String, isJokers: Bool = false) {
    let category = Self.strength(for: rawValue)

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
