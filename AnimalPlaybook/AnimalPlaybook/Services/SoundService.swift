import Combine
import AVFoundation
import SwiftUI

enum PlaybackState {
    case stopped
    case playing
    case paused
}

class SoundService: ObservableObject {
    private var audioPlayer: AVAudioPlayer?
    private var audioPlayerDelegate: AudioPlayerDelegate?
    private let logger: LoggerService
    
    @Published var isSoundEnabled: Bool = true {
        didSet {
            UserDefaults.standard.set(isSoundEnabled, forKey: "isSoundEnabled")
            logger.info("Sound enabled changed to: \(isSoundEnabled)", category: "SoundService")
        }
    }
    @Published var currentPlayingSound: SoundsAnimal?
    @Published var playbackState: PlaybackState = .stopped
    
    init(logger: LoggerService = LoggerService.shared) {
        self.logger = logger
        isSoundEnabled = UserDefaults.standard.bool(forKey: "isSoundEnabled")
        logger.info("SoundService initialized. Sound enabled: \(isSoundEnabled)", category: "SoundService")
    }
    
    func playSound(for category: AnimalCategory) {
        guard isSoundEnabled else {
            logger.debug("Sound playback skipped - sound is disabled", category: "SoundService")
            return
        }
        
        guard let url = Bundle.main.url(forResource: category.soundFileName, withExtension: "mp3") else {
            logger.warning("Sound file not found: \(category.soundFileName).mp3", category: "SoundService")
            return
        }
        
        logger.info("Playing sound for category: \(category.rawValue)", category: "SoundService")
        playSound(from: url)
    }
    
    func playSound(from soundFile: SoundsAnimal) {
        guard isSoundEnabled else {
            logger.debug("Sound playback skipped - sound is disabled", category: "SoundService")
            return
        }
        
        if currentPlayingSound?.id == soundFile.id && playbackState == .paused {
            logger.info("Resuming paused sound: \(soundFile.displayName)", category: "SoundService")
            resumeSound()
            return
        }
        
        if currentPlayingSound?.id != soundFile.id && playbackState == .playing {
            logger.debug("Stopping current sound to play new one", category: "SoundService")
            stopSound()
        }
        
        var url = Bundle.main.url(forResource: soundFile.fileName, withExtension: soundFile.fileExtension, subdirectory: "Sounds")
        
        if url == nil {
            url = Bundle.main.url(forResource: soundFile.fileName, withExtension: soundFile.fileExtension)
        }
        
        guard let soundURL = url else {
            logger.warning("Sound file not found: \(soundFile.fullFileName)", category: "SoundService")
            return
        }
        
        logger.info("Playing sound: \(soundFile.displayName)", category: "SoundService")
        playSound(from: soundURL, soundFile: soundFile)
    }
    
    private func playSound(from url: URL, soundFile: SoundsAnimal? = nil) {
        do {
            logger.debug("Initializing audio player for URL: \(url.lastPathComponent)", category: "SoundService")
            if audioPlayer != nil {
                audioPlayer?.stop()
            }
            
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayerDelegate = AudioPlayerDelegate { [weak self] in
                DispatchQueue.main.async {
                    self?.logger.debug("Audio playback finished", category: "SoundService")
                    self?.currentPlayingSound = nil
                    self?.playbackState = .stopped
                }
            }
            audioPlayer?.delegate = audioPlayerDelegate
            audioPlayer?.play()
            
            if let soundFile = soundFile {
                currentPlayingSound = soundFile
                playbackState = .playing
                logger.success("Sound started playing: \(soundFile.displayName)", category: "SoundService")
            }
        } catch {
            logger.error("Error playing sound: \(error.localizedDescription)", category: "SoundService")
        }
    }
    
    private class AudioPlayerDelegate: NSObject, AVAudioPlayerDelegate {
        let onFinish: () -> Void
        
        init(onFinish: @escaping () -> Void) {
            self.onFinish = onFinish
        }
        
        func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
            onFinish()
        }
    }
    
    func pauseSound() {
        guard playbackState == .playing else {
            logger.debug("Cannot pause - sound is not playing", category: "SoundService")
            return
        }
        logger.info("Pausing sound", category: "SoundService")
        audioPlayer?.pause()
        playbackState = .paused
    }
    
    func resumeSound() {
        guard playbackState == .paused else {
            logger.debug("Cannot resume - sound is not paused", category: "SoundService")
            return
        }
        logger.info("Resuming sound", category: "SoundService")
        audioPlayer?.play()
        playbackState = .playing
    }
    
    func stopSound() {
        logger.info("Stopping sound", category: "SoundService")
        audioPlayer?.stop()
        audioPlayer = nil
        audioPlayerDelegate = nil
        currentPlayingSound = nil
        playbackState = .stopped
    }
    
    func toggleSound() {
        logger.info("Toggling sound enabled", category: "SoundService")
        isSoundEnabled.toggle()
        if !isSoundEnabled {
            stopSound()
        }
    }
    
    func isPlaying(_ soundFile: SoundsAnimal) -> Bool {
        currentPlayingSound?.id == soundFile.id && playbackState == .playing
    }
    
    func isPaused(_ soundFile: SoundsAnimal) -> Bool {
        currentPlayingSound?.id == soundFile.id && playbackState == .paused
    }
    
    func playSound(forAnimalName animalName: String) {
        guard isSoundEnabled else {
            logger.debug("Sound playback skipped for \(animalName) - sound is disabled", category: "SoundService")
            return
        }
        
        logger.debug("Searching for sound file for animal: \(animalName)", category: "SoundService")
        let lowercasedName = animalName.lowercased()
        let possibleExtensions = ["mp3", "m4a", "wav", "aiff"]
        
        var url: URL?
        var foundExtension: String?
        
        for ext in possibleExtensions {
            url = Bundle.main.url(forResource: lowercasedName, withExtension: ext, subdirectory: "Sounds")
            if url == nil {
                url = Bundle.main.url(forResource: lowercasedName, withExtension: ext)
            }
            if url != nil {
                foundExtension = ext
                break
            }
        }
        
        guard let soundURL = url, let ext = foundExtension else {
            logger.warning("Sound file not found for animal: \(animalName)", category: "SoundService")
            return
        }
        
        logger.debug("Found sound file: \(lowercasedName).\(ext)", category: "SoundService")
        let soundFile = SoundsAnimal(
            fileName: lowercasedName,
            displayName: animalName,
            fileExtension: ext
        )
        
        playSound(from: soundURL, soundFile: soundFile)
    }
}

