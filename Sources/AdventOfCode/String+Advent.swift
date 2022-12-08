import Foundation

private enum PatternMatchError: Error {
    case noMatches
    case notImplemented
}

extension String {
    func matchPattern(_ pattern: String, matches: inout [String]) throws {
        let regex = try NSRegularExpression(pattern: pattern)
        let range = NSRange(startIndex..<endIndex, in: self)
        var error: Error?
        regex.enumerateMatches(in: self, options: [], range: range) { match, _, stop in
            guard let match = match, match.numberOfRanges == matches.count + 1 else {
                error = PatternMatchError.noMatches
                return
            }

            for i in 1 ..< match.numberOfRanges {
                if let range = Range(match.range(at: i), in: self) {
                    matches[i-1] = String(self[range])
                }
            }
            stop.pointee = true
        }
        if let error = error {
            throw error
        }
    }
}