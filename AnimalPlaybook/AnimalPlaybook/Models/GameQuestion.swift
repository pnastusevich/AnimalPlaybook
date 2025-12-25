import Foundation

struct GameQuestion {
    let animal: Animal
    let options: [String]
    let correctAnswer: String
    
    static func generateQuestion(from animals: [Animal], correctAnimal: Animal? = nil) -> GameQuestion? {
        guard animals.count >= 3 else { return nil }
        
        let shuffled = animals.shuffled()
        let correctAnimal = correctAnimal ?? shuffled[0]
        
        let wrongOptions = shuffled.filter { $0.name != correctAnimal.name }
        
        var options = [correctAnimal.name]
        options.append(contentsOf: wrongOptions.prefix(3).map { $0.name })
        
        return GameQuestion(
            animal: correctAnimal,
            options: options.shuffled(),
            correctAnswer: correctAnimal.name
        )
    }
}

