import Foundation

enum LetterResult {
  case correct, contained, incorrect
}

public func run() {
  guard var words = wordList() else {
    print("Unable to get words")
    return
  }
  print("Loaded \(words.count) words")
  
  while words.count > 1 {
    print("Enter guess", terminator: ": ")
    guard let guess = readLine() else { return }
    print("Enter guess result", terminator: ": ")
    guard let guessResultRaw = readLine() else { return }
    let guessResult: [LetterResult] = guessResultRaw.compactMap { result in
      switch result {
      case "g":
        return .correct
      case "y":
        return .contained
      case "b":
        return .incorrect
      default:
        return nil
      }
    }
    words = prune(words: words, guess: guess, result: guessResult)
    print("Possible words\n=====")
    for word in words {
      print(word)
    }
    print("=====")
  }
}

func prune(words: Set<String>, guess: String, result: [LetterResult]) -> Set<String> {
  return words.filter { word in
    return matchResult(guess: guess, target: word) == result
  }
}

func matchResult(guess: String, target: String) -> [LetterResult] {
  assert(guess.count == target.count, "Guess and Target words must be same length")
  var result = Array<LetterResult>(repeating: .incorrect, count: target.count)
  // match correct letters first
  zip(guess, target).enumerated().forEach { letter in
    if letter.element.0 == letter.element.1 {
      result[letter.offset] = .correct
    }
  }
  // for remaining characters, see if they're completely incorrect or just in a diff position
  var charCounts: [String.Element:Int] = [:]
  zip(target, result).forEach { (letter, letterResult) in
    // count number of times each incorrectly placed character in the target shows up
    guard letterResult != .correct else { return }
    charCounts[letter] = (charCounts[letter] ?? 0) + 1
  }
  guess.enumerated().forEach { (i, letter) in
    guard result[i] != .correct else { return }
    if let numChars = charCounts[letter], numChars > 0 {
      // if the target (excluding correct letters) contains the guess letter, we mark it as contained
      result[i] = .contained
      charCounts[letter] = numChars - 1
    }
  }
  return result
}

func wordList() -> Set<String>? {
  guard let wordListPath = Bundle.module.path(forResource: "wordList", ofType: "txt") else { return nil }
  guard let rawWords = try? String(contentsOfFile: wordListPath) else { return nil }
  let words = rawWords.split(separator: "\n")
  var wordSet = Set<String>(minimumCapacity: words.count)
  words.forEach { wordSet.insert(String($0)) }
  return wordSet
}

extension String {
  func charAt(pos: Int) -> Element {
    return self[self.index(self.startIndex, offsetBy: pos)]
  }
}
