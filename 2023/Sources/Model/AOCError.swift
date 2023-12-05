import Foundation

enum AOCError: LocalizedError {
  case custom(String)

  var errorDescription: String? {
    switch self {
    case .custom(let msg): return msg
    }
  }
}
