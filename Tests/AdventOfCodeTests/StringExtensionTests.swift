@testable import AdventOfCode
import XCTest

final class StringExtensionTests: XCTestCase {
    func testMatchPattern() throws {
        let tests: [(input: String, pattern: String, want: [String])] = [
            ("move 1 from 2 to 3", "^move ([0-9]+) from ([0-9]+) to ([0-9]+)$", ["1", "2", "3"]),
            ("move 6 from 1 to 5", "^move ([0-9]+) from ([0-9]+) to ([0-9]+)$", ["6", "1", "5"]),
            ("move 23 from 17 to 9", "^move ([0-9]+) from ([0-9]+) to ([0-9]+)$", ["23", "17", "9"]),
            ("24-57,13-29", "^([0-9]+)-([0-9]+),([0-9]+)-([0-9]+)$", ["24", "57", "13", "29"])
        ]

        for test in tests {
            var got = [String](repeating: "", count: test.want.count)
            try test.input.matchPattern(test.pattern, matches: &got)
            XCTAssertEqual(test.want, got)
        }
    }
}