@testable import AdventOfCodeObjc
import XCTest
import class Foundation.Bundle

final class Day08Tests: XCTestCase {
    private var sampleInput = """
    30373
    25512
    65332
    33549
    35390

    """
    func testAerialMapFromInput() throws {
        let want = [[3,0,3,7,3], [2,5,5,1,2], [6,5,3,3,2], [3,3,5,4,9], [3,5,3,9,0]]
        let sut = Day08(input: sampleInput)
        let got = sut.aerialMap(from: sampleInput) as? [[Int]]
        XCTAssertEqual(want, got)
    }

    func testMaxScenicScoreInMap() throws {
        let input: [[NSNumber]] = [[3,0,3,7,3], [2,5,5,1,2], [6,5,3,3,2], [3,3,5,4,9], [3,5,3,9,0]]
        let want: NSNumber = 8
        let sut = Day08(input: sampleInput)
        let got = sut.maxScenicScore(inAerialMap: input)
        XCTAssertEqual(got, want)
    }

    func testVisibleTreesInAerialMap() throws {
        let input: [[NSNumber]] = [[3,0,3,7,3], [2,5,5,1,2], [6,5,3,3,2], [3,3,5,4,9], [3,5,3,9,0]]
        let want: [NSNumber] = [3,0,3,7,3, 2,5,5,2, 6,5,3,2, 3,5,9, 3,5,3,9,0];
        let sut = Day08(input: sampleInput)
        let got = sut.visibleTrees(inAerialMap: input)
        XCTAssertEqual(got, want)
        XCTAssertEqual(got.count, 21)
    }
}
