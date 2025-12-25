
import SwiftUI
import Combine

enum QuestionMode {
    case image
    case sound
}

enum GameState {
    case notStarted
    case playing
    case finished
}

class GameViewModel: ObservableObject {
    @Published var gameState: GameState = .notStarted
    @Published var currentQuestion: GameQuestion?
    @Published var currentQuestionMode: QuestionMode = .image
    @Published var score: Int = 0
    @Published var currentLevel: Int = 1
    @Published var currentQuestionIndex: Int = 0
    @Published var isAnswered: Bool = false
    @Published var selectedAnswer: String?
    @Published var isPlayingSound: Bool = false
    @Published var isSoundEnabled: Bool = true
    @Published var levelAttempts: Int = 0
    @Published var finalScore: Int = 0
    @Published var finalLevel: Int = 1
    @Published var isVictory: Bool = false
    @Published var showLevelCompleteAlert: Bool = false
    @Published var levelCompleteMessage: String = ""
    @Published var wrongAnswers: Set<String> = []
    @Published var levelAnimals: [Animal] = []
    
    private let soundService: SoundService
    private let logger: LoggerService
    private let settingsViewModel: SettingsViewModel
    private let animals: [Animal] = {
        let availableSounds = SoundsAnimal.loadAllSounds()
        let soundNames = Set(availableSounds.map { $0.fileName.lowercased() })
        
        return Animal.sampleAnimals.filter { animal in
            let animalName = animal.name.lowercased()
            return soundNames.contains(animalName)
        }
    }()
    
    private var cancellables = Set<AnyCancellable>()
    
    init(soundService: SoundService = SoundService(), logger: LoggerService = LoggerService.shared, settingsViewModel: SettingsViewModel = SettingsViewModel()) {
        self.soundService = soundService
        self.logger = logger
        self.settingsViewModel = settingsViewModel
        logger.info("GameViewModel initialized with \(animals.count) animals", category: "GameViewModel")
        setupSubscriptions()
    }
    
    private func setupSubscriptions() {
        soundService.$isSoundEnabled
            .sink { [weak self] newValue in
                self?.isSoundEnabled = newValue
            }
            .store(in: &cancellables)
        
        soundService.$currentPlayingSound
            .sink { [weak self] playingSound in
                guard let self = self, let question = self.currentQuestion else { return }
                let animalName = question.animal.name.lowercased()
                self.isPlayingSound = playingSound?.fileName.lowercased() == animalName && 
                                     self.soundService.playbackState == .playing
            }
            .store(in: &cancellables)
        
        soundService.$playbackState
            .sink { [weak self] state in
                guard let self = self, let question = self.currentQuestion else { return }
                let animalName = question.animal.name.lowercased()
                self.isPlayingSound = self.soundService.currentPlayingSound?.fileName.lowercased() == animalName && 
                                     state == .playing
            }
            .store(in: &cancellables)
    }
    
    func startGame() {
        logger.info("Starting new game", category: "GameViewModel")
        gameState = .playing
        score = 0
        currentLevel = 1
        currentQuestionIndex = 0
        levelAttempts = 0
        wrongAnswers.removeAll()
        startLevel(1)
    }
    
    func startLevel(_ levelNumber: Int) {
        guard let level = GameLevel.level(at: levelNumber - 1) else {
            logger.error("Invalid level number: \(levelNumber)", category: "GameViewModel")
            return
        }
        
        logger.info("Starting level \(levelNumber): \(level.animalsCount) animals, \(level.maxAttempts) attempts", category: "GameViewModel")
        
        currentLevel = levelNumber
        currentQuestionIndex = 0
        levelAttempts = 0
        wrongAnswers.removeAll()
        
        levelAnimals = Array(animals.shuffled().prefix(level.animalsCount))
        
        generateNextQuestion()
    }
    
    func generateNextQuestion() {
        guard currentQuestionIndex < levelAnimals.count else {
            completeLevel()
            return
        }
        
        logger.debug("Generating question \(currentQuestionIndex + 1)/\(levelAnimals.count) for level \(currentLevel)", category: "GameViewModel")
        
        if isPlayingSound {
            soundService.stopSound()
        }
        
        let animal = levelAnimals[currentQuestionIndex]
        currentQuestion = GameQuestion.generateQuestion(from: animals, correctAnimal: animal)
        
        currentQuestionMode = Bool.random() ? .sound : .image
        
        isAnswered = false
        selectedAnswer = nil
        isPlayingSound = false
        wrongAnswers.removeAll()
        
        if let question = currentQuestion {
            logger.info("Generated question: \(question.animal.name), mode: \(currentQuestionMode == .sound ? "sound" : "image")", category: "GameViewModel")
        }
    }
    
    func completeLevel() {
        logger.success("Level \(currentLevel) completed! Score: \(score)", category: "GameViewModel")
        
        let isLastLevel = GameLevel.level(at: currentLevel) == nil
        
        if isLastLevel {
            finishGame(isVictory: true)
        } else {
            levelCompleteMessage = "Level \(currentLevel) Completed! 🎉\nScore: \(score)\n\nGet ready for Level \(currentLevel + 1)!"
            showLevelCompleteAlert = true
        }
    }
    
    func proceedToNextLevel() {
        showLevelCompleteAlert = false
        
        if let nextLevel = GameLevel.level(at: currentLevel) {
            startLevel(currentLevel + 1)
        }
    }
    
    func finishGame(isVictory: Bool) {
        logger.info("Game finished. Victory: \(isVictory), Score: \(score), Level: \(currentLevel)", category: "GameViewModel")
        
        gameState = .finished
        finalScore = score
        finalLevel = currentLevel
        self.isVictory = isVictory
        
        if isVictory {
            settingsViewModel.updateBestScore(score)
        } else {
            settingsViewModel.updateBestScore(score)
        }
        
        if isPlayingSound {
            soundService.stopSound()
        }
    }
    
    func playSound() {
        guard let question = currentQuestion, !isAnswered else { return }
        logger.info("Playing sound for question: \(question.animal.name)", category: "GameViewModel")
        soundService.playSound(forAnimalName: question.animal.name)
    }
    
    func stopSound() {
        logger.info("Stopping sound", category: "GameViewModel")
        soundService.stopSound()
    }
    
    func selectAnswer(_ answer: String) {
        guard !isAnswered else { return }
        guard let level = GameLevel.level(at: currentLevel - 1) else { return }
        
        if wrongAnswers.contains(answer) {
            return
        }
        
        logger.info("Answer selected: \(answer). Level attempts: \(levelAttempts + 1)/\(level.maxAttempts)", category: "GameViewModel")
        selectedAnswer = answer
        
        if isPlayingSound {
            soundService.stopSound()
        }
        
        if answer == currentQuestion?.correctAnswer {
            score += 1
            isAnswered = true
            logger.success("Correct answer! Score: \(score)", category: "GameViewModel")
        } else {
            wrongAnswers.insert(answer)
            levelAttempts += 1
            
            if levelAttempts >= level.maxAttempts {
                isAnswered = true
                logger.warning("Game over. Level attempts exhausted. Final score: \(score)", category: "GameViewModel")
                
                finishGame(isVictory: false)
            } else {
                logger.warning("Incorrect answer. Level attempts: \(levelAttempts)/\(level.maxAttempts). Correct was: \(currentQuestion?.correctAnswer ?? "unknown")", category: "GameViewModel")
                selectedAnswer = nil
            }
        }
    }
    
    func resetGame() {
        logger.info("Resetting game", category: "GameViewModel")
        gameState = .notStarted
        score = 0
        currentLevel = 1
        currentQuestionIndex = 0
        levelAttempts = 0
        wrongAnswers.removeAll()
        if isPlayingSound {
            soundService.stopSound()
        }
    }
    
    func nextQuestion() {
        guard isAnswered else { return }
        currentQuestionIndex += 1
        generateNextQuestion()
    }
    
    var currentLevelInfo: GameLevel? {
        GameLevel.level(at: currentLevel - 1)
    }
    
    var levelProgress: Double {
        guard let level = currentLevelInfo else { return 0 }
        return Double(currentQuestionIndex) / Double(level.animalsCount)
    }
    
    var canProceedToNext: Bool {
        isAnswered && currentQuestionIndex < (currentLevelInfo?.animalsCount ?? 0)
    }
}

