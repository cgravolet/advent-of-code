@testable import AdventOfCode
import XCTest
import class Foundation.Bundle

final class Day09Tests: XCTestCase {
    private var sampleInput = """
    R 4
    U 4
    L 3
    D 1
    R 4
    D 1
    L 5
    R 2

    """

    func testMakeInstructions() throws {
        let want: [Direction] = [.right(4), .up(4), .left(3), .down(1), .right(4), .down(1), .left(5), .right(2)]
        let sut = Day09()
        let got = sut.makeInstructions(fromString: sampleInput)
        XCTAssertEqual(got, want)
    }

    func testIsTouching() throws {
        let tests: [(lhs: IntPoint, rhs: IntPoint, want: Bool)] = [
            (IntPoint(100, 100), IntPoint(100, 100), true),
            (IntPoint(100, 100), IntPoint(99, 100), true),
            (IntPoint(100, 100), IntPoint(98, 100), false),
            (IntPoint(100, 100), IntPoint(101, 100), true),
            (IntPoint(100, 100), IntPoint(102, 100), false),
            (IntPoint(100, 100), IntPoint(100, 99), true),
            (IntPoint(100, 100), IntPoint(100, 98), false),
            (IntPoint(100, 100), IntPoint(100, 101), true),
            (IntPoint(100, 100), IntPoint(100, 102), false),
            (IntPoint(100, 100), IntPoint(99, 99), true),
            (IntPoint(100, 100), IntPoint(98, 99), false),
            (IntPoint(100, 100), IntPoint(99, 98), false),
            (IntPoint(100, 100), IntPoint(101, 99), true),
            (IntPoint(100, 100), IntPoint(101, 98), false),
            (IntPoint(100, 100), IntPoint(101, 101), true),
            (IntPoint(100, 100), IntPoint(101, 102), false)
        ]

        for test in tests {
            let got = test.lhs.isTouching(test.rhs)
            XCTAssertEqual(got, test.want)
        }
    }

    func testSolve1() throws {
        let want = 13
        let sut = Day09()
        let instructions = sut.makeInstructions(fromString: sampleInput)
        let got = sut.solve1(instructions: instructions)
        XCTAssertEqual(got, want)
    }
}