import Foundation

struct GameLevel {
    let levelNumber: Int
    let animalsCount: Int
    let maxAttempts: Int
    
    static let allLevels: [GameLevel] = [
        GameLevel(levelNumber: 1, animalsCount: 3, maxAttempts: 3),
        GameLevel(levelNumber: 2, animalsCount: 4, maxAttempts: 3),
        GameLevel(levelNumber: 3, animalsCount: 6, maxAttempts: 2),
        GameLevel(levelNumber: 4, animalsCount: 7, maxAttempts: 2),
        GameLevel(levelNumber: 5, animalsCount: 8, maxAttempts: 1),
        GameLevel(levelNumber: 6, animalsCount: 9, maxAttempts: 1),
        GameLevel(levelNumber: 7, animalsCount: 10, maxAttempts: 1)
    ]
    
    static func level(at index: Int) -> GameLevel? {
        guard index >= 0 && index < allLevels.count else { return nil }
        return allLevels[index]
    }
}

