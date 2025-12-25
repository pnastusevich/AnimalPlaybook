
import Foundation

struct Animal: Identifiable, Hashable {
    let id = UUID()
    let emoji: String
    let name: String
    let category: AnimalCategory
    let description: String
    
    static let sampleAnimals: [Animal] = [
        // Mammals
        Animal(emoji: "🦁", name: "Lion", category: .animal, description: "The lion is a large predatory mammal, known as the king of the jungle. It lives in the savannas of Africa."),
        Animal(emoji: "🐘", name: "Elephant", category: .animal, description: "The elephant is the largest land mammal. Known for its long trunk and excellent memory."),
        Animal(emoji: "🐼", name: "Panda", category: .animal, description: "The giant panda is a rare mammal that lives in China. It feeds mainly on bamboo."),
        Animal(emoji: "🐺", name: "Wolf", category: .animal, description: "The wolf is a predatory mammal that lives in packs. Known for its howl and hunting skills."),
        Animal(emoji: "🐻", name: "Bear", category: .animal, description: "The bear is a large omnivorous mammal. It hibernates in winter."),
        Animal(emoji: "🦊", name: "Fox", category: .animal, description: "The fox is a predatory mammal known for its cunning and red fur."),
        Animal(emoji: "🐱", name: "Cat", category: .animal, description: "The cat is a small domesticated carnivorous mammal. Known for its independence and agility."),
        Animal(emoji: "🐶", name: "Dog", category: .animal, description: "The dog is a domesticated mammal and loyal companion to humans."),
        Animal(emoji: "🐴", name: "Horse", category: .animal, description: "The horse is a large hoofed mammal, used for riding and work for thousands of years."),
        Animal(emoji: "🐷", name: "Pig", category: .animal, description: "The pig is an intelligent domesticated mammal, often raised for meat."),
        Animal(emoji: "🐄", name: "Cow", category: .animal, description: "The cow is a large domesticated mammal, raised for milk and meat."),
        Animal(emoji: "🐐", name: "Goat", category: .animal, description: "The goat is a sure-footed mammal, known for its ability to climb steep terrain."),
        Animal(emoji: "🦔", name: "Hedgehog", category: .animal, description: "The hedgehog is a small spiny mammal that curls into a ball when threatened."),
        Animal(emoji: "🐆", name: "Jaguar", category: .animal, description: "The jaguar is a large wild cat native to the Americas, known for its powerful bite."),
        Animal(emoji: "🐅", name: "Tiger", category: .animal, description: "The tiger is the largest cat species, known for its distinctive orange coat with black stripes."),
        
        // Birds
        Animal(emoji: "🦅", name: "Eagle", category: .bird, description: "The eagle is a large bird of prey with excellent eyesight. A symbol of strength and freedom."),
        Animal(emoji: "🦉", name: "Owl", category: .bird, description: "The owl is a nocturnal bird of prey with large eyes and silent flight."),
        Animal(emoji: "🦜", name: "Parrot", category: .bird, description: "The parrot is a bright tropical bird known for its ability to mimic human speech."),
        Animal(emoji: "🐧", name: "Penguin", category: .bird, description: "The penguin is a flightless bird that lives in Antarctica. An excellent swimmer."),
        Animal(emoji: "🦆", name: "Duck", category: .bird, description: "The duck is a waterfowl with webbed feet. It lives near water bodies."),
        Animal(emoji: "🦚", name: "Peacock", category: .bird, description: "The peacock is a beautiful bird with bright plumage. Known for its magnificent tail."),
        Animal(emoji: "🐔", name: "Chicken", category: .bird, description: "The chicken is a domesticated bird, one of the most common farm animals."),
        Animal(emoji: "🐦‍⬛", name: "Crow", category: .bird, description: "The crow is an intelligent black bird, known for its problem-solving abilities."),
        Animal(emoji: "🪿", name: "Goose", category: .bird, description: "The goose is a waterfowl bird, known for its honking call and migratory behavior."),
        
        // Insects
        Animal(emoji: "🦋", name: "Butterfly", category: .insect, description: "The butterfly is a beautiful insect with bright wings. It goes through the caterpillar stage."),
        Animal(emoji: "🐝", name: "Bee", category: .insect, description: "The bee is a beneficial insect that pollinates plants and produces honey."),
        Animal(emoji: "🐞", name: "Ladybug", category: .insect, description: "The ladybug is a small insect with red wings and black spots."),
        Animal(emoji: "🦗", name: "Grasshopper", category: .insect, description: "The grasshopper is a jumping insect known for its chirping."),
        Animal(emoji: "🕷️", name: "Spider", category: .insect, description: "The spider is an eight-legged arachnid that weaves webs to catch prey."),
        Animal(emoji: "🐜", name: "Ant", category: .insect, description: "The ant is a social insect that lives in colonies. Very hardworking."),
        
        // Fish
        Animal(emoji: "🦈", name: "Shark", category: .fish, description: "The shark is a large predatory fish with sharp teeth. It lives in the oceans."),
        Animal(emoji: "🐸", name: "Frog", category: .fish, description: "The frog is an amphibian that lives both in water and on land. Known for its croaking.")
    ]
}

