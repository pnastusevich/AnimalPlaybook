import SwiftUI
import Combine

class MainTabCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController?
    var logger = LoggerService.shared
    
    let soundService: SoundService
    let settingsViewModel: SettingsViewModel
    let animalsViewModel: AnimalsViewModel
    let soundsViewModel: SoundsViewModel
    let gameViewModel: GameViewModel
    
    var rootView: MainTabView {
        MainTabView(
            coordinator: self,
            soundService: soundService,
            settingsViewModel: settingsViewModel,
            animalsViewModel: animalsViewModel,
            soundsViewModel: soundsViewModel,
            gameViewModel: gameViewModel
        )
    }
    
    init() {
        self.soundService = SoundService(logger: logger)
        self.settingsViewModel = SettingsViewModel(soundService: soundService, logger: logger)
        self.animalsViewModel = AnimalsViewModel(soundService: soundService, logger: logger)
        self.soundsViewModel = SoundsViewModel(soundService: soundService, logger: logger)
        self.gameViewModel = GameViewModel(soundService: soundService, logger: logger, settingsViewModel: settingsViewModel)
        
        logger.info("MainTabCoordinator initialized", category: "MainTabCoordinator")
    }
    
    func start() {
        logger.info("Starting MainTabCoordinator", category: "MainTabCoordinator")
        
        let animalsCoordinator = AnimalsCoordinator(
            viewModel: animalsViewModel,
            settingsViewModel: settingsViewModel,
            logger: logger
        )
        addChildCoordinator(animalsCoordinator)
        
        logger.success("MainTabCoordinator started successfully", category: "MainTabCoordinator")
    }
    
    func finish() {
        logger.info("Finishing MainTabCoordinator", category: "MainTabCoordinator")
        removeAllChildCoordinators()
    }
    
    func showAnimalDetail(_ animal: Animal) {
        logger.info("Showing animal detail for: \(animal.name)", category: "MainTabCoordinator")
    }
}

