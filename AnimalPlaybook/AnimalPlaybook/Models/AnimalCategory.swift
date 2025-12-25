
import Foundation

enum AnimalCategory: String, CaseIterable, Identifiable {
    case animal = "Animal"
    case bird = "Bird"
    case insect = "Insect"
    case fish = "Fish"
    
    var id: String { rawValue }
    
    var soundFileName: String {
        switch self {
        case .animal: return "animal"
        case .bird: return "bird"
        case .insect: return "insect"
        case .fish: return "fish"
        }
    }
    
    var englishName: String {
        switch self {
        case .animal: return "Animal"
        case .bird: return "Bird"
        case .insect: return "Insect"
        case .fish: return "Fish"
        }
    }
}

