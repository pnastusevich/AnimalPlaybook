import SwiftUI

struct GameStartView: View {
    @ObservedObject var viewModel: GameViewModel
    
    var body: some View {
        ScrollView {
            VStack(spacing: AdaptiveSize.spacing(32)) {
                Text("🐾")
                    .font(.system(size: AdaptiveSize.fontSize(120)))
                    .adaptivePadding(.top, 30)
                
                VStack(spacing: AdaptiveSize.spacing(16)) {
                    Text("Animal Playbook Game")
                        .font(.system(size: AdaptiveSize.fontSize(28), weight: .bold))
                        .foregroundColor(.primary)
                    
                    Text("Guess the animals by their sounds or images!")
                        .font(.system(size: AdaptiveSize.fontSize(16)))
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.center)
                        .adaptivePadding(.horizontal, 24)
                    
                    VStack(alignment: .leading, spacing: AdaptiveSize.spacing(12)) {
                        Text("How to play:")
                            .font(.system(size: AdaptiveSize.fontSize(18), weight: .semibold))
                            .adaptivePadding(.horizontal, 24)
                        
                        VStack(alignment: .leading, spacing: AdaptiveSize.spacing(8)) {
                            GameRuleRow(icon: "🎯", text: "Complete 7 levels with increasing difficulty")
                            GameRuleRow(icon: "🎵", text: "Listen to sounds or look at images")
                            GameRuleRow(icon: "⭐", text: "Earn points for correct answers")
                            GameRuleRow(icon: "⚠️", text: "Limited attempts per level")
                        }
                        .adaptivePadding(.horizontal, 24)
                    }
                }
                
                Button(action: {
                    viewModel.startGame()
                }) {
                    Text("Start Game")
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

