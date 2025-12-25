import SwiftUI

struct AnswerOptionsView: View {
    let question: GameQuestion
    @ObservedObject var viewModel: GameViewModel
    
    var body: some View {
        LazyVGrid(columns: [
            GridItem(.flexible(), spacing: AdaptiveSize.spacing(10)),
            GridItem(.flexible(), spacing: AdaptiveSize.spacing(10))
        ], spacing: AdaptiveSize.spacing(12)) {
            ForEach(question.options, id: \.self) { option in
                AnswerButton(
                    text: option,
                    isCorrect: option == question.correctAnswer,
                    isSelected: viewModel.selectedAnswer == option,
                    isWrong: viewModel.wrongAnswers.contains(option),
                    isAnswered: viewModel.isAnswered,
                    showCorrect: viewModel.isAnswered && option == question.correctAnswer
                ) {
                    viewModel.selectAnswer(option)
                }
            }
        }
        .adaptivePadding(.horizontal, 20)
        .adaptivePadding(.top, 24)
    }
}

