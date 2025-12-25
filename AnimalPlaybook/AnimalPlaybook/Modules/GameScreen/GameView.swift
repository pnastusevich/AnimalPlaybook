import SwiftUI

struct GameView: View {
    @ObservedObject var viewModel: GameViewModel
    
    var body: some View {
        NavigationStack {
            Group {
                switch viewModel.gameState {
                case .notStarted:
                    GameStartView(viewModel: viewModel)
                case .playing:
                    GamePlayingView(viewModel: viewModel)
                case .finished:
                    GameFinishedView(viewModel: viewModel)
                }
            }
            .navigationTitle("Game")
            .alert("Level Complete!", isPresented: $viewModel.showLevelCompleteAlert) {
                Button("Continue") {
                    viewModel.proceedToNextLevel()
                }
            } message: {
                Text(viewModel.levelCompleteMessage)
            }
        }
    }
}

#Preview {
    GameView(viewModel: GameViewModel())
}

