@testable import AdventOfCode
import XCTest
import class Foundation.Bundle

final class Day07Tests: XCTestCase {
    private let sampleInput = """
    $ cd /
    $ ls
    dir a
    14848514 b.txt
    8504156 c.dat
    dir d
    $ cd a
    $ ls
    dir e
    29116 f
    2557 g
    62596 h.lst
    $ cd e
    $ ls
    584 i
    $ cd ..
    $ cd ..
    $ cd d
    $ ls
    4060174 j
    8033020 d.log
    5626152 d.ext
    7214296 k

    """

    // MARK: - Tests

    func testFindMinSizeOfDeletionCandidates() throws {
        let sut = Day07()
        let tree = sut.makeDirTree(fromConsoleHistory: sampleInput)
        let got = sut.findMinSizeOfDeletionCandidates(inTree: tree, total: 70000000, required: 30000000)
        let want = 24933642
        XCTAssertEqual(got, want)
    }

    func testFindTotalSizeOfDirectories() throws {
        let sut = Day07()
        let tree = sut.makeDirTree(fromConsoleHistory: sampleInput)
        let got = sut.findTotalSizeOfDeletionCandidates(inTree: tree, max: 100000)
        let want = 95437
        XCTAssertEqual(got, want)
    }

    func testMakeDirTree() throws {
        let sut = Day07()
        let got = sut.makeDirTree(fromConsoleHistory: sampleInput)
        XCTAssertEqual(got.children.count, 4)
        XCTAssertEqual(got.size, 48381165)
    }
}
