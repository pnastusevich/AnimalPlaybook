
import Combine
import SwiftUI

class LearnViewModel: ObservableObject {
    @Published var facts: [AnimalFact] = AnimalFact.sampleFacts
    @Published var selectedCategory: AnimalCategory?
    
    private let logger: LoggerService
    
    init(logger: LoggerService = LoggerService.shared) {
        self.logger = logger
        logger.info("LearnViewModel initialized with \(facts.count) facts", category: "LearnViewModel")
    }
    
    var filteredFacts: [AnimalFact] {
        guard let category = selectedCategory else { return facts }
        return facts.filter { $0.category == category }
    }
    
    func filterByCategory(_ category: AnimalCategory?) {
        logger.debug("Filtering facts by category: \(category?.rawValue ?? "All")", category: "LearnViewModel")
        selectedCategory = category
        let filtered = filteredFacts
        logger.debug("Filtered to \(filtered.count) facts", category: "LearnViewModel")
    }
}

