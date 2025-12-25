import SwiftUI

struct GameFinishedView: View {
    @ObservedObject var viewModel: GameViewModel
    
    var body: some View {
        ScrollView {
            VStack(spacing: AdaptiveSize.spacing(32)) {
                Text(viewModel.isVictory ? "🏆" : "😔")
                    .font(.system(size: AdaptiveSize.fontSize(120)))
                    .adaptivePadding(.top, 40)
                
                VStack(spacing: AdaptiveSize.spacing(20)) {
                    Text(viewModel.isVictory ? "Congratulations!" : "Game Over")
                        .font(.system(size: AdaptiveSize.fontSize(32), weight: .bold))
                        .foregroundColor(.primary)
                    
                    Text(viewModel.isVictory ? "You completed all levels!" : "You ran out of attempts")
                        .font(.system(size: AdaptiveSize.fontSize(18)))
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.center)
                        .adaptivePadding(.horizontal, 24)
                    
                    VStack(spacing: AdaptiveSize.spacing(16)) {
                        GameResultRow(
                            icon: "⭐",
                            label: "Final Score",
                            value: "\(viewModel.finalScore)"
                        )
                        
                        GameResultRow(
                            icon: "📊",
                            label: "Level Reached",
                            value: "\(viewModel.finalLevel)"
                        )
                    }
                    .adaptivePadding(.horizontal, 24)
                    .adaptivePadding(.vertical, 20)
                    .background(Color(.systemGray5))
                    .cornerRadius(AdaptiveSize.scale(16))
                    .adaptivePadding(.horizontal, 24)
                }
                
                Button(action: {
                    viewModel.resetGame()
                }) {
                    Text("Play Again")
                        .font(.system(size: AdaptiveSize.fontSize(18), weight: .semibold))
                        .frame(maxWidth: .infinity)
                        .adaptivePadding(.all, 16)
                        .background(Color.accentColor)
                        .foregroundColor(.white)
                        .cornerRadius(AdaptiveSize.scale(16))
                }
                .adaptivePadding(.horizontal, 24)
                .adaptivePadding(.bottom, 40)
            }
        }
    }
}

