import SwiftUI
import Combine

class AppCoordinator: Coordinator, ObservableObject {
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController?
    var logger = LoggerService.shared
    
    @Published var mainTabCoordinator: MainTabCoordinator?
    
    func start() {
        logger.info("Starting AppCoordinator", category: "AppCoordinator")
        
        let mainTabCoordinator = MainTabCoordinator()
        self.mainTabCoordinator = mainTabCoordinator
        addChildCoordinator(mainTabCoordinator)
        mainTabCoordinator.start()
        
        logger.success("AppCoordinator started successfully", category: "AppCoordinator")
    }
    
    func finish() {
        logger.info("Finishing AppCoordinator", category: "AppCoordinator")
        removeAllChildCoordinators()
    }
}

