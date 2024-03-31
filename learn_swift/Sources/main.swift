// The Swift Programming Language
// https://docs.swift.org/swift-book

enum Suit {
    case spades, hearts, diamonds, clubs


    func simpleDescription() -> String {
        switch self {
        case .spades:
            return "spades"
        case .hearts:
            return "hearts"
        case .diamonds:
            return "diamonds"
        case .clubs:
            return "clubs"
        }
    }
}
let hearts = Suit.hearts
let heartsDescription = hearts.simpleDescription()

print(hearts)
print(heartsDescription)
