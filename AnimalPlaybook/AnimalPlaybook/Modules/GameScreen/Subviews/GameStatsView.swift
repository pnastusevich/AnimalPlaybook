import SwiftUI

struct GameStatsView: View {
    @ObservedObject var viewModel: GameViewModel
    
    var body: some View {
        VStack(spacing: AdaptiveSize.spacing(8)) {
            HStack(spacing: AdaptiveSize.spacing(40)) {
                VStack(spacing: AdaptiveSize.spacing(4)) {
                    Text("Level")
                        .font(.system(size: AdaptiveSize.fontSize(12), weight: .medium))
                        .foregroundColor(.secondary)
                    Text("\(viewModel.currentLevel)")
                        .font(.system(size: AdaptiveSize.fontSize(24), weight: .bold))
                        .foregroundColor(.accentColor)
                }
                
                VStack(spacing: AdaptiveSize.spacing(4)) {
                    Text("Score")
                        .font(.system(size: AdaptiveSize.fontSize(12), weight: .medium))
                        .foregroundColor(.secondary)
                    Text("\(viewModel.score)")
                        .font(.system(size: AdaptiveSize.fontSize(24), weight: .bold))
                        .foregroundColor(.accentColor)
                }
                
                if let level = viewModel.currentLevelInfo {
                    VStack(spacing: AdaptiveSize.spacing(4)) {
                        Text("Attempts")
                            .font(.system(size: AdaptiveSize.fontSize(12), weight: .medium))
                            .foregroundColor(.secondary)
                        Text("\(viewModel.levelAttempts)/\(level.maxAttempts)")
                            .font(.system(size: AdaptiveSize.fontSize(20), weight: .semibold))
                            .foregroundColor(viewModel.levelAttempts >= level.maxAttempts ? .red : .primary)
                    }
                }
            }
            
            if let level = viewModel.currentLevelInfo {
                VStack(spacing: AdaptiveSize.spacing(4)) {
                    HStack {
                        Text("Progress: \(viewModel.currentQuestionIndex)/\(level.animalsCount)")
                            .font(.system(size: AdaptiveSize.fontSize(12), weight: .medium))
                            .foregroundColor(.secondary)
                        Spacer()
                    }
                    ProgressView(value: viewModel.levelProgress)
                        .progressViewStyle(.linear)
                }
            }
        }
        .adaptivePadding(.horizontal, 16)
        .adaptivePadding(.top, 16)
    }
}

