@testable import AdventOfCode
import XCTest

final class Day15Tests: XCTestCase {
    private var sampleInput = """
    Sensor at x=2, y=18: closest beacon is at x=-2, y=15
    Sensor at x=9, y=16: closest beacon is at x=10, y=16
    Sensor at x=13, y=2: closest beacon is at x=15, y=3
    Sensor at x=12, y=14: closest beacon is at x=10, y=16
    Sensor at x=10, y=20: closest beacon is at x=10, y=16
    Sensor at x=14, y=17: closest beacon is at x=10, y=16
    Sensor at x=8, y=7: closest beacon is at x=2, y=10
    Sensor at x=2, y=0: closest beacon is at x=2, y=10
    Sensor at x=0, y=11: closest beacon is at x=2, y=10
    Sensor at x=20, y=14: closest beacon is at x=25, y=17
    Sensor at x=17, y=20: closest beacon is at x=21, y=22
    Sensor at x=16, y=7: closest beacon is at x=15, y=3
    Sensor at x=14, y=3: closest beacon is at x=15, y=3
    Sensor at x=20, y=1: closest beacon is at x=15, y=3
    """

    func testPart1() throws {
        let sut = Day15()
        let want = 26
        let got = try sut.part1(sampleInput, row: 10)
        XCTAssertEqual(got, want)
    }

    func testPart2() throws {
        let sut = Day15()
        let want = 56000011
        let got = try sut.part2(sampleInput, max: 20)
        XCTAssertEqual(got, want)
    }

    func testGetCoordsOutsideRange() throws {
        let sut = Day15()
        let want = Set<Coord>([
            Coord(0, 5), Coord(1, 4), Coord(1, 6), Coord(2, 3), Coord(2, 7), Coord(3, 2), Coord(3, 8), Coord(4, 1),
            Coord(4, 9), Coord(5, 2), Coord(5, 8), Coord(6, 3), Coord(6, 7), Coord(7, 4), Coord(7, 6), Coord(8, 5)
        ])
        let got = sut.getCoordsOutsideRange(of: Coord(4, 5), distance: 3, min: 0, max: 20)
        XCTAssertEqual(got, want)
    }
}