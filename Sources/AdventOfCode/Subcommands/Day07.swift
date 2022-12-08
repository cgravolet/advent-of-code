import ArgumentParser
import Foundation

class Node {
    enum NodeType {
        case directory, file
    }

    private(set) var children: [Node]
    let name: String
    weak private(set) var parent: Node?
    let size: Int
    let type: NodeType

    init(name: String, size: Int = 0, type: NodeType, children: [Node] = [], parent: Node? = nil) {
        self.children = children
        self.name = name
        self.parent = parent
        self.size = size
        self.type = type
    }

    func addChild(_ node: Node) {
        children.append(node)
        node.parent = self
    }
}

struct Day07: ParsableCommand {
    static let configuration = CommandConfiguration(abstract: "Advent of Code - 2022 December 7", version: "1.0.0")

    // MARK: - Options

    @Option(name: .shortAndLong, help: "Input file path")
    var path: String = "input/day07.txt"

    // MARK: - Lifecycle

    mutating func run() throws {
        let tree = makeTree(fromConsoleHistory: try String(contentsOfFile: path))
        print("Day 7 answer (part 1): \(tree)")
    }

    // MARK: - Internal methods

    func makeTree(fromConsoleHistory history: String) -> Node {
        let root = Node(name: ".", type: .directory)
        var walk: [Node] = [root]

        for line in history.components(separatedBy: .newlines) {
            switch line.first {
            // Traversal
            case "$":
                do {
                    var matches = [String](repeating: "", count: 1)
                    try line.matchPattern("^\\$ cd (.+)$", matches: &matches)

                    switch matches[0] {
                    case "/":
                        walk = [walk.first!]
                    case "..":
                        walk.removeLast()
                    default:
                        let children = walk.last?.children
                        if let dir = children?.first(where: { $0.name == matches[0] && $0.type == .directory}) {
                            walk.append(dir)
                        }
                    }
                } catch {
                    // no-op
                }

            // Directory
            case "d":
                do {
                    var matches = [String](repeating: "", count: 1)
                    try line.matchPattern("^dir (.+)$", matches: &matches)
                    walk.last?.addChild(Node(name: matches[0], type: .directory))
                } catch {
                    // no-op
                }

            // File
            default:
                do {
                    var matches = [String](repeating: "", count: 2)
                    try line.matchPattern("^([0-9]+) (.+)$", matches: &matches)
                    walk.last?.addChild(Node(name: matches[1], size: Int(matches[0]) ?? 0, type: .file))
                } catch {
                    // no-op
                }
                break
            }
        }
        return root
    }
}