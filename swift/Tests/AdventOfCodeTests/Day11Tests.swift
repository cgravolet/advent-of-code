@testable import AdventOfCode
import XCTest
import class Foundation.Bundle

final class Day11Tests: XCTestCase {
    private var sampleInput = """
    Monkey 0:
      Starting items: 79, 98
      Operation: new = old * 19
      Test: divisible by 23
        If true: throw to monkey 2
        If false: throw to monkey 3

    Monkey 1:
      Starting items: 54, 65, 75, 74
      Operation: new = old + 6
      Test: divisible by 19
        If true: throw to monkey 2
        If false: throw to monkey 0

    Monkey 2:
      Starting items: 79, 60, 97
      Operation: new = old * old
      Test: divisible by 13
        If true: throw to monkey 1
        If false: throw to monkey 3

    Monkey 3:
      Starting items: 74
      Operation: new = old + 3
      Test: divisible by 17
        If true: throw to monkey 0
        If false: throw to monkey 1
    """

    func testCalculateMonkeyBusiness() throws {
        let tests: [(input: [Day11.Monkey], want: Day11.MonkeyBusiness)] = [
            ([Day11.Monkey(29), Day11.Monkey(2), Day11.Monkey(32)], 928),
            ([Day11.Monkey(2), Day11.Monkey(9), Day11.Monkey(120), Day11.Monkey(13), Day11.Monkey(19)], 2280)
        ]
        let sut = Day11()

        for test in tests {
            let got = sut.calculateMonkeyBusiness(monkeys: test.input)
            XCTAssertEqual(got, test.want)
        }
    }

    func testObserveMonkeys() throws {
        let sut = Day11()
        let tests: [(indexFalse: Int, indexTrue: Int, inventory: [Day11.WorryLevel], quotient: Int, rhs: String)] = [
            (3, 2, [79, 98], 23, "19"),
            (0, 2, [54, 65, 75, 74], 19, "6"),
            (3, 1, [79, 60, 97], 13, "old"),
            (1, 0, [74], 17, "3")
        ]
        let monkeys = try sut.observeMonkeys(notes: sampleInput)

        guard monkeys.count == tests.count else {
            XCTFail("expected \(tests.count), got \(monkeys.count)")
            return
        }

        for (i, test) in tests.enumerated() {
            let got = monkeys[i]
            XCTAssertEqual(test.indexFalse, got.indexFalse)
            XCTAssertEqual(test.indexTrue, got.indexTrue)
            XCTAssertEqual(test.inventory, got.inventory)
            XCTAssertEqual(test.quotient, got.quotient)
        }
    }

    func testSolvePart1() throws {
        let sut = Day11()
        let monkeys = try sut.observeMonkeys(notes: sampleInput)
        let want: Day11.MonkeyBusiness = 10605
        let got = sut.solvePart1(monkeys: monkeys)
        XCTAssertEqual(got, want)
    }

    func testSolvePart2() throws {
        let sut = Day11()
        let monkeys = try sut.observeMonkeys(notes: sampleInput)
        let want: Day11.MonkeyBusiness = 2713310158
        let got = sut.solvePart2(monkeys: monkeys)
        XCTAssertEqual(got, want)
    }
}

extension Day11.Monkey {
    init(_ inspections: Int) {
        self.init(indexFalse: 0, indexTrue: 0, inspections: inspections, inventory: [], operation: "",
                  quotient: 0, rhs: "")
    }
}