import SwiftUI

struct GamePlayingView: View {
    @ObservedObject var viewModel: GameViewModel
    
    var body: some View {
        ScrollView {
            VStack(spacing: AdaptiveSize.spacing(24)) {
                GameStatsView(viewModel: viewModel)
                
                if let question = viewModel.currentQuestion {
                    QuestionContentView(
                        question: question,
                        questionMode: viewModel.currentQuestionMode,
                        isPlayingSound: viewModel.isPlayingSound,
                        isSoundEnabled: viewModel.isSoundEnabled,
                        onPlaySound: { viewModel.playSound() },
                        onStopSound: { viewModel.stopSound() }
                    )
                    
                    AnswerOptionsView(
                        question: question,
                        viewModel: viewModel
                    )
                    
                    if viewModel.canProceedToNext {
                        Button(action: {
                            viewModel.nextQuestion()
                        }) {
                            Text("Next Question")
                                .font(.system(size: AdaptiveSize.fontSize(16), weight: .semibold))
                                .frame(maxWidth: .infinity)
                                .adaptivePadding(.all, 14)
                                .background(Color.accentColor)
                                .foregroundColor(.white)
                                .cornerRadius(AdaptiveSize.scale(12))
                        }
                        .adaptivePadding(.horizontal, 20)
                        .adaptivePadding(.top, 18)
                    }
                }
                Spacer()
                    .frame(height: AdaptiveSize.scale(20))
            }
        }
    }
}

