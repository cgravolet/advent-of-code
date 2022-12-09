@testable import AdventOfCode
import XCTest
import class Foundation.Bundle

final class Day09Tests: XCTestCase {
    private var smallSample = """
    R 4
    U 4
    L 3
    D 1
    R 4
    D 1
    L 5
    R 2
    """

    private var largeSample = """
    R 5
    U 8
    L 8
    D 3
    R 17
    D 10
    L 25
    U 20
    """

    func testMakeInstructions() throws {
        let want: [Day09.Direction] = [.right(4), .up(4), .left(3), .down(1), .right(4), .down(1), .left(5), .right(2)]
        let sut = Day09()
        let got = sut.makeInstructions(fromString: smallSample)
        XCTAssertEqual(got, want)
    }

    func testIsTouching() throws {
        let tests: [(lhs: Day09.IntPoint, rhs: Day09.IntPoint, want: Bool)] = [
            (.init(100, 100), .init(100, 100), true),
            (.init(100, 100), .init(99, 100), true),
            (.init(100, 100), .init(98, 100), false),
            (.init(100, 100), .init(101, 100), true),
            (.init(100, 100), .init(102, 100), false),
            (.init(100, 100), .init(100, 99), true),
            (.init(100, 100), .init(100, 98), false),
            (.init(100, 100), .init(100, 101), true),
            (.init(100, 100), .init(100, 102), false),
            (.init(100, 100), .init(99, 99), true),
            (.init(100, 100), .init(98, 99), false),
            (.init(100, 100), .init(99, 98), false),
            (.init(100, 100), .init(101, 99), true),
            (.init(100, 100), .init(101, 98), false),
            (.init(100, 100), .init(101, 101), true),
            (.init(100, 100), .init(101, 102), false)
        ]

        for test in tests {
            let got = test.lhs.isTouching(test.rhs)
            XCTAssertEqual(got, test.want)
        }
    }

    func testSolve1() throws {
        let want = 13
        let sut = Day09()
        let instructions = sut.makeInstructions(fromString: smallSample)
        let got = sut.solve(instructions: instructions, ropeSize: 2)
        XCTAssertEqual(got, want)
    }

    func testSolve2() throws {
        let want = 36
        let sut = Day09()
        let instructions = sut.makeInstructions(fromString: largeSample)
        let got = sut.solve(instructions: instructions, ropeSize: 10)
        XCTAssertEqual(got, want)
    }
}