
import SwiftUI

@main
struct AnimalPlaybookApp: App {
    @StateObject private var appCoordinator: AppCoordinator = {
        let coordinator = AppCoordinator()
        coordinator.start()
        return coordinator
    }()
    
    var body: some Scene {
        WindowGroup {
            Group {
                if let mainTabCoordinator = appCoordinator.mainTabCoordinator {
                    mainTabCoordinator.rootView
                } else {
                    ProgressView()
                }
            }
        }
    }
}
