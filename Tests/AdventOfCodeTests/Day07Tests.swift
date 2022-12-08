@testable import AdventOfCode
import XCTest
import class Foundation.Bundle

final class Day07Tests: XCTestCase {
    func testFindMarker() throws {
        let tests: [(input: String, size: Int, want: Int)] = [
            ("bvwbjplbgvbhsrlpgdmjqwftvncz", 4, 5),
            ("nppdvjthqldpwncqszvftbrmjlhg", 4, 6),
            ("nznrnfrfntjfmvfwmzdfjlvtqnbhcprsg", 4, 10),
            ("zcfzfwzzqfrljwzlrfnpqdbhtmscgvjw", 4, 11),
            ("mjqjpqmgbljsphdztnvjfqwrcgsmlb", 14, 19),
            ("bvwbjplbgvbhsrlpgdmjqwftvncz", 14, 23),
            ("nppdvjthqldpwncqszvftbrmjlhg", 14, 23),
            ("nznrnfrfntjfmvfwmzdfjlvtqnbhcprsg", 14, 29),
            ("zcfzfwzzqfrljwzlrfnpqdbhtmscgvjw", 14, 26),
        ]
        let sut = Day06()

        for test in tests {
            let got = try sut.findMarker(inStream: test.input, size: test.size)
            XCTAssertEqual(got, test.want)
        }
    }
}
