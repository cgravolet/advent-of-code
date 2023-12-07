import Foundation

struct AOCError: LocalizedError {
  let errorDescription: String?

  init(_ message: String) {
    self.errorDescription = message
  }
}
