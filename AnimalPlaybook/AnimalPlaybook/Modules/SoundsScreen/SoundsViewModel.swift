import Combine
import SwiftUI

class SoundsViewModel: ObservableObject {
    @Published var soundFiles: [SoundsAnimal] = []
    @Published var isSoundEnabled: Bool = true
    @Published var currentPlayingSound: SoundsAnimal?
    @Published var playbackState: PlaybackState = .stopped
    
    private let soundService: SoundService
    private let logger: LoggerService
    private var cancellables = Set<AnyCancellable>()
    
    init(soundService: SoundService = SoundService(), logger: LoggerService = LoggerService.shared) {
        self.soundService = soundService
        self.logger = logger
        logger.info("SoundsViewModel initialized", category: "SoundsViewModel")
        loadSounds()
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
    
    private func loadSounds() {
        logger.debug("Loading sound files", category: "SoundsViewModel")
        soundFiles = SoundsAnimal.loadAllSounds()
        logger.success("Loaded \(soundFiles.count) sound files", category: "SoundsViewModel")
        if soundFiles.isEmpty {
            logger.warning("No sound files found. Check that files are in the Sounds folder and added to the bundle.", category: "SoundsViewModel")
        } else {
            logger.debug("Sound files: \(soundFiles.map { $0.displayName }.joined(separator: ", "))", category: "SoundsViewModel")
        }
    }
    
    func playSound(from soundFile: SoundsAnimal) {
        logger.info("Playing sound: \(soundFile.displayName)", category: "SoundsViewModel")
        soundService.playSound(from: soundFile)
    }
    
    func pauseSound() {
        logger.info("Pausing sound", category: "SoundsViewModel")
        soundService.pauseSound()
    }
    
    func resumeSound() {
        logger.info("Resuming sound", category: "SoundsViewModel")
        soundService.resumeSound()
    }
    
    func stopSound() {
        logger.info("Stopping sound", category: "SoundsViewModel")
        soundService.stopSound()
    }
    
    func isPlaying(_ soundFile: SoundsAnimal) -> Bool {
        currentPlayingSound?.id == soundFile.id && playbackState == .playing
    }
    
    func isPaused(_ soundFile: SoundsAnimal) -> Bool {
        currentPlayingSound?.id == soundFile.id && playbackState == .paused
    }
}

