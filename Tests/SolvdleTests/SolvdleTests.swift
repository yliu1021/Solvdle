import XCTest
import class Foundation.Bundle
@testable import Solvdle

final class SolvdleTests: XCTestCase {
  func testMatchResultIncorrect() {
    XCTAssertEqual(
      matchResult(guess: "abcde", target: "fghij"),
      Array<LetterResult>(repeating: .incorrect, count: 5)
    )
  }
  
  func testMatchResultCorrect() {
    XCTAssertEqual(
      matchResult(guess: "abcde", target: "abcde"),
      Array<LetterResult>(repeating: .correct, count: 5)
    )
  }
  
  func testMatchResultContained() {
    XCTAssertEqual(
      matchResult(guess: "abcde", target: "bcdea"),
      Array<LetterResult>(repeating: .contained, count: 5)
    )
  }
  
  func testMatchResultContainedDouble() {
    XCTAssertEqual(
      matchResult(guess: "abcee", target: "eabce"),
      [.contained, .contained, .contained, .contained, .correct]
    )
  }
  
  func testMatchResultContainedMismatch() {
    XCTAssertEqual(
      matchResult(guess: "aeebe", target: "zzzee"),
      [.incorrect, .contained, .incorrect, .incorrect, .correct]
    )
  }
}
