import SwiftUI

class AnimalsCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController?
    var logger: LoggerService
    
    private let animalsViewModel: AnimalsViewModel
    private let settingsViewModel: SettingsViewModel
    
    init(
        viewModel: AnimalsViewModel,
        settingsViewModel: SettingsViewModel,
        logger: LoggerService = LoggerService.shared
    ) {
        self.animalsViewModel = viewModel
        self.settingsViewModel = settingsViewModel
        self.logger = logger
        
        logger.info("AnimalsCoordinator initialized", category: "AnimalsCoordinator")
    }
    
    func start() {
        logger.info("Starting AnimalsCoordinator", category: "AnimalsCoordinator")
        logger.success("AnimalsCoordinator started successfully", category: "AnimalsCoordinator")
    }
    
    func finish() {
        logger.info("Finishing AnimalsCoordinator", category: "AnimalsCoordinator")
        removeAllChildCoordinators()
    }
    
    func showAnimalDetail(_ animal: Animal) {
        logger.info("Navigating to animal detail: \(animal.name)", category: "AnimalsCoordinator")
        animalsViewModel.selectedAnimal = animal
    }
    
    func dismissAnimalDetail() {
        logger.info("Dismissing animal detail", category: "AnimalsCoordinator")
        animalsViewModel.selectedAnimal = nil
    }
}

