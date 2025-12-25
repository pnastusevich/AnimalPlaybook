
import Combine
import SwiftUI

enum DisplayStyle: String, CaseIterable {
    case cards = "Cards"
    case list = "List"
}

class SettingsViewModel: ObservableObject {
    @AppStorage("displayStyle") var displayStyle: String = DisplayStyle.cards.rawValue
    @AppStorage("bestScore") var bestScore: Int = 0
    @Published var isSoundEnabled: Bool = true
    
    private let soundService: SoundService
    private let logger: LoggerService
    private var cancellables = Set<AnyCancellable>()
    private var isUpdatingFromService = false
    
    init(soundService: SoundService = SoundService(), logger: LoggerService = LoggerService.shared) {
        self.soundService = soundService
        self.logger = logger
        isSoundEnabled = soundService.isSoundEnabled
        logger.info("SettingsViewModel initialized. Sound enabled: \(isSoundEnabled)", category: "SettingsViewModel")
        setupSubscriptions()
    }
    
    private func setupSubscriptions() {
        soundService.$isSoundEnabled
            .sink { [weak self] (newValue: Bool) in
                guard let self = self, !self.isUpdatingFromService else { return }
                self.isUpdatingFromService = true
                self.isSoundEnabled = newValue
                self.isUpdatingFromService = false
            }
            .store(in: &cancellables)
    }
    
    func setSoundEnabled(_ enabled: Bool) {
        guard !isUpdatingFromService else { return }
        logger.info("Setting sound enabled: \(enabled)", category: "SettingsViewModel")
        isUpdatingFromService = true
        isSoundEnabled = enabled
        soundService.isSoundEnabled = enabled
        isUpdatingFromService = false
    }
    
    var currentDisplayStyle: DisplayStyle {
        DisplayStyle(rawValue: displayStyle) ?? .cards
    }
    
    func setDisplayStyle(_ style: DisplayStyle) {
        logger.info("Setting display style to: \(style.rawValue)", category: "SettingsViewModel")
        displayStyle = style.rawValue
    }
    
    var animalsWithSoundsCount: Int {
        let availableSounds = SoundsAnimal.loadAllSounds()
        let soundNames = Set(availableSounds.map { $0.fileName.lowercased() })
        return Animal.sampleAnimals.filter { soundNames.contains($0.name.lowercased()) }.count
    }
    
    func updateBestScore(_ newScore: Int) {
        if newScore > bestScore {
            logger.info("New best score: \(newScore) (previous: \(bestScore))", category: "SettingsViewModel")
            bestScore = newScore
        }
    }
}

