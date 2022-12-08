import ArgumentParser
import Foundation

class Node {
    enum NodeType {
        case directory, file
    }

    private(set) var children: [Node]
    let name: String
    weak private(set) var parent: Node?
    var size: Int
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
        size += node.size
    }
}

struct Day07: ParsableCommand {
    static let configuration = CommandConfiguration(abstract: "Advent of Code - 2022 December 7", version: "1.0.0")

    // MARK: - Options

    @Option(name: .shortAndLong, help: "Input file path")
    var path: String = "input/day07.txt"

    // MARK: - Lifecycle

    mutating func run() throws {
        let tree = makeDirTree(fromConsoleHistory: try String(contentsOfFile: path))
        let part1 = findTotalSizeOfDeletionCandidates(inTree: tree, max: 100000)
        let part2 = findMinSizeOfDeletionCandidates(inTree: tree, total: 70000000, required: 30000000)
        print("Day 7 answer (part 1): \(part1)")
        print("Day 7 answer (part 2): \(part2)")
    }

    // MARK: - Internal methods

    func findMinSizeOfDeletionCandidates(inTree tree: Node, total: Int, required: Int) -> Int {
        let unusedSpace = total - tree.size
        let deletionSpace = required - unusedSpace

        func findMinDirectorySizeForDeletion(node: Node, required: Int) -> Int? {
            var result: Int?
            if node.type == .directory && node.size > required {
                result = node.size
            }
            for child in node.children {
                if let value = findMinDirectorySizeForDeletion(node: child, required: required) {
                    if let res = result, value < res {
                        result = value
                    } else if result == nil {
                        result = value
                    }
                }
            }
            return result
        }
        return findMinDirectorySizeForDeletion(node: tree, required: deletionSpace) ?? 0
    }

    func findTotalSizeOfDeletionCandidates(inTree tree: Node, max: Int) -> Int {
        var sum = 0
        if tree.type == .directory && tree.size < max {
            sum += tree.size
        }
        for node in tree.children {
            sum += findTotalSizeOfDeletionCandidates(inTree: node, max: max)
        }
        return sum
    }

    func makeDirTree(fromConsoleHistory history: String) -> Node {
        let root = Node(name: ".", type: .directory)
        var currentNode = root

        for line in history.components(separatedBy: .newlines) {
            let components = line.components(separatedBy: .whitespaces)

            switch components.first {
            // Traversal
            case "$":
                guard components.count == 3 else { continue }

                switch components[2] {
                case "/":
                    while let parent = currentNode.parent {
                        currentNode = parent
                    }
                case "..":
                    if let parent = currentNode.parent {
                        currentNode = parent
                    }
                default:
                    let dir = currentNode.children.first { $0.name == components[2] && $0.type == .directory }
                    currentNode = dir ?? currentNode
                }

            // Directory
            case "dir":
                guard components.count == 2 else { continue }
                currentNode.addChild(Node(name: components[1], type: .directory))

            // File
            default:
                guard components.count == 2 else { continue }
                let size = Int(components[0]) ?? 0
                let node = Node(name: components[1], size: size, type: .file)
                currentNode.addChild(node)

                // Update size of parent directories
                var currentParent = currentNode.parent

                while let parent = currentParent, parent.type == .directory {
                    parent.size += size
                    currentParent = parent.parent
                }
            }
        }
        return root
    }
}