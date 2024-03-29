import ArgumentParser

let allPuzzles: [any Puzzle] = [
  Puzzle202301(), Puzzle202302(), Puzzle202303(), Puzzle202304(), Puzzle202305(),
  Puzzle202306(), Puzzle202307(), Puzzle202308(), Puzzle202309(), Puzzle202310(),
  Puzzle202311(), Puzzle202312(), Puzzle202313(), Puzzle202314(), Puzzle202315(),
  Puzzle202316(), Puzzle202317(), Puzzle202318(), Puzzle202319(),
]

@main
struct AdventOfCode: ParsableCommand {
  @Argument(help: "The year and day of the challenge (i.e. \"202301\" for 2023 December 01).")
  var day: Int?

  @Flag(help: "Benchmark the time taken by the solution")
  var benchmark: Bool = false

  // MARK: - Private properties

  private var latestPuzzle: any Puzzle {
    get throws {
      guard let puzzle = allPuzzles.max(by: { $0.day < $1.day }) else {
        throw ValidationError("Latest solution could not be found")
      }
      return puzzle
    }
  }

  private var selectedPuzzle: any Puzzle {
    get throws {
      if let day {
        if let puzzle = allPuzzles.first(where: { $0.day == day }) {
          return puzzle
        } else {
          throw ValidationError("No solution found for day \(day)")
        }
      } else {
        return try latestPuzzle
      }
    }
  }

  // MARK: - Public methods

  func run() throws {
    let puzzle = try selectedPuzzle
    print("Executing Advent of Code puzzle \(puzzle.day)...\n")

    let timing1 = run(part: puzzle.solve1, named: "Part 1")
    let timing2 = run(part: puzzle.solve2, named: "Part 2")

    if benchmark {
      print("\nPart 1 took \(timing1), part 2 took \(timing2)")
      #if DEBUG
        print("\nLooks like you're benchmarking debug code, try: swift run -c release")
      #endif
    }
  }

  func run(part: () throws -> Any, named: String) -> Duration {
    var result: Result<Any, Error> = .success("<unsolved>")

    let timing = ContinuousClock().measure {
      do {
        result = .success(try part())
      } catch {
        result = .failure(error)
      }
    }

    switch result {
    case .success(let result): print("\(named): \(result)")
    case .failure(let err): print("\(named) FAIL: \(err)")
    }
    return timing
  }
}
