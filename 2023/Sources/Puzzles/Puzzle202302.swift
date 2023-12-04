import Algorithms
import Collections
import Foundation

struct Puzzle202302: Puzzle {
  let input: [String]

  init(input: String) {
    self.input = input.components(separatedBy: .newlines)
  }

  // MARK: - Public methods

  func solve1() throws -> Any {
    input
      .compactMap(parseGameSets)
      .filter { isPossible($0, blue: 14, green: 13, red: 12) }
      .compactMap(\.first?.id)
      .reduce(0, +)
  }

  func solve2() throws -> Any {
    input
      .compactMap(parseGameSets)
      .map(getMinimumSetPower)
      .reduce(0, +)
  }

  // MARK: - Private methods

  /// Returns the power (blue * green * red) of the minimum amount of cubes needed for the given collection
  /// of GameSet's.
  private func getMinimumSetPower(from gameSets: [GameSet]) -> Int {
    let blue = gameSets.map(\.blue).max() ?? 0
    let green = gameSets.map(\.green).max() ?? 0
    let red = gameSets.map(\.red).max() ?? 0
    return blue * green * red
  }

  /// Returns a Boolean value indicating if the colleciton of GameSet's is possible with the given amount of cubes.
  private func isPossible(_ gameSets: [GameSet], blue: Int, green: Int, red: Int) -> Bool {
    let invalidSets = gameSets.filter {
      $0.blue > blue || $0.green > green || $0.red > red
    }
    return invalidSets.count == 0
  }

  /// Parses a String (i.e. "5 red, 2 blue, 3 green") into a GameSet.
  private func parseGameSet(_ input: String, id: Int) -> GameSet {
    var blue = 0
    var green = 0
    var red = 0

    for str in input.split(separator: ",") {
      let num = String(str).toInt()

      if str.contains("blue") {
        blue = num
      } else if str.contains("green") {
        green = num
      } else if str.contains("red") {
        red = num
      }
    }
    return .init(id: id, blue: blue, green: green, red: red)
  }

  /// Parses a String (i.e. "Game 1: 3 blue; 4 red, 2 green; 3 green") into a collection of GameSet's with
  /// matching `id`.
  private func parseGameSets(_ input: String) -> [GameSet]? {
    let components = input.split(separator: ":")
    guard components.count == 2 else { return nil }
    let gameId = String(components[0]).toInt()
    return components[1].split(separator: ";").map { parseGameSet(String($0), id: gameId) }
  }
}
