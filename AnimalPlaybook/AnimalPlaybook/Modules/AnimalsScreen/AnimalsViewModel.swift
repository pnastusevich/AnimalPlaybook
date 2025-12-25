
import Combine
import SwiftUI

class AnimalsViewModel: ObservableObject {
    @Published var animals: [Animal] = []
    @Published var selectedAnimal: Animal?
    @Published var isSoundEnabled: Bool = true
    @Published var currentPlayingSound: SoundsAnimal?
    @Published var playbackState: PlaybackState = .stopped
    
    private let soundService: SoundService
    private let logger: LoggerService
    private var cancellables = Set<AnyCancellable>()
    
    init(soundService: SoundService = SoundService(), logger: LoggerService = LoggerService.shared) {
        self.soundService = soundService
        self.logger = logger
        isSoundEnabled = soundService.isSoundEnabled
        currentPlayingSound = soundService.currentPlayingSound
        playbackState = soundService.playbackState
        logger.info("AnimalsViewModel initialized", category: "AnimalsViewModel")
        loadAnimalsWithSounds()
        setupSubscriptions()
    }
    
    private func setupSubscriptions() {
        soundService.$isSoundEnabled
            .sink { [weak self] newValue in
                self?.isSoundEnabled = newValue
            }
            .store(in: &cancellables)
        
        soundService.$currentPlayingSound
            .sink { [weak self] newValue in
                self?.currentPlayingSound = newValue
            }
            .store(in: &cancellables)
        
        soundService.$playbackState
            .sink { [weak self] newValue in
                self?.playbackState = newValue
            }
            .store(in: &cancellables)
    }
    
    private func loadAnimalsWithSounds() {
        logger.debug("Loading animals with sounds", category: "AnimalsViewModel")
        let availableSounds = SoundsAnimal.loadAllSounds()
        let soundNames = Set(availableSounds.map { $0.fileName.lowercased() })
        
        animals = Animal.sampleAnimals.filter { animal in
            let animalName = animal.name.lowercased()
            return soundNames.contains(animalName)
        }
        
        logger.success("Loaded \(animals.count) animals with sounds out of \(Animal.sampleAnimals.count) total", category: "AnimalsViewModel")
    }
    
    func filterAnimals(by category: AnimalCategory?) -> [Animal] {
        logger.debug("Filtering animals by category: \(category?.rawValue ?? "All")", category: "AnimalsViewModel")
        guard let category = category else { return animals }
        let filtered = animals.filter { $0.category == category }
        logger.debug("Filtered to \(filtered.count) animals", category: "AnimalsViewModel")
        return filtered
    }
    
    func playSound(forAnimalName animalName: String) {
        logger.info("Playing sound for animal: \(animalName)", category: "AnimalsViewModel")
        soundService.playSound(forAnimalName: animalName)
    }
    
    func stopSound() {
        logger.info("Stopping sound", category: "AnimalsViewModel")
        soundService.stopSound()
    }
    
    func isPlayingSound(forAnimalName animalName: String) -> Bool {
        let lowercasedName = animalName.lowercased()
        return currentPlayingSound?.fileName.lowercased() == lowercasedName && playbackState == .playing
    }
}

