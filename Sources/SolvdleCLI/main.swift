import ArgumentParser
import Solvdle

struct SolvdleCLI: ParsableCommand {
    @Argument()
    var numWords: Int = 1

    func run() {
        Solvdle.run(numWords: self.numWords)
    }
}

SolvdleCLI.main()
