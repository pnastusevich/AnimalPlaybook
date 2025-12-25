
import SwiftUI

struct MainTabView: View {
    let coordinator: MainTabCoordinator
    @StateObject private var soundService: SoundService
    @StateObject private var settingsViewModel: SettingsViewModel
    @StateObject private var animalsViewModel: AnimalsViewModel
    @StateObject private var soundsViewModel: SoundsViewModel
    @StateObject private var gameViewModel: GameViewModel
    
    init(
        coordinator: MainTabCoordinator,
        soundService: SoundService,
        settingsViewModel: SettingsViewModel,
        animalsViewModel: AnimalsViewModel,
        soundsViewModel: SoundsViewModel,
        gameViewModel: GameViewModel
    ) {
        self.coordinator = coordinator
        _soundService = StateObject(wrappedValue: soundService)
        _settingsViewModel = StateObject(wrappedValue: settingsViewModel)
        _animalsViewModel = StateObject(wrappedValue: animalsViewModel)
        _soundsViewModel = StateObject(wrappedValue: soundsViewModel)
        _gameViewModel = StateObject(wrappedValue: gameViewModel)
    }
    
    var body: some View {
        TabView {
            AnimalsView(
                viewModel: animalsViewModel,
                settingsViewModel: settingsViewModel,
                coordinator: coordinator
            )
            .tabItem {
                Label("Animals", systemImage: "pawprint.fill")
            }
            
            SoundsView(viewModel: soundsViewModel)
                .tabItem {
                    Label("Sounds", systemImage: "speaker.wave.2.fill")
                }
            
            GameView(viewModel: gameViewModel)
                .tabItem {
                    Label("Game", systemImage: "gamecontroller.fill")
                }
            
            LearnView()
                .tabItem {
                    Label("Learn", systemImage: "book.fill")
                }
            
            SettingsView(viewModel: settingsViewModel)
                .tabItem {
                    Label("Settings", systemImage: "gearshape.fill")
                }
        }
    }
}

#Preview {
    let coordinator = MainTabCoordinator()
    MainTabView(
        coordinator: coordinator,
        soundService: coordinator.soundService,
        settingsViewModel: coordinator.settingsViewModel,
        animalsViewModel: coordinator.animalsViewModel,
        soundsViewModel: coordinator.soundsViewModel,
        gameViewModel: coordinator.gameViewModel
    )
}

