import SwiftUI

struct AnswerButton: View {
    let text: String
    let isCorrect: Bool
    let isSelected: Bool
    let isWrong: Bool
    let isAnswered: Bool
    let showCorrect: Bool
    let action: () -> Void
    
    var backgroundColor: Color {
        if showCorrect {
            return Color.green
        } else if isWrong {
            return Color.red
        } else {
            return Color(.systemGray5)
        }
    }
    
    var foregroundColor: Color {
        if showCorrect {
            return .white
        } else if isWrong {
            return .white
        } else {
            return .primary
        }
    }
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: AdaptiveSize.spacing(8)) {
                Text(text)
                    .font(.system(size: AdaptiveSize.fontSize(16), weight: .medium))
                    .foregroundColor(foregroundColor)
                    .lineLimit(1)
                    .minimumScaleFactor(0.8)
                
                Spacer()
                
                if isAnswered {
                    if showCorrect {
                        Image(systemName: "checkmark.circle.fill")
                            .font(.system(size: AdaptiveSize.fontSize(18)))
                            .foregroundColor(.white)
                    } else if isWrong {
                        Image(systemName: "xmark.circle.fill")
                            .font(.system(size: AdaptiveSize.fontSize(18)))
                            .foregroundColor(.white)
                    }
                }
            }
            .adaptivePadding(.all, 12)
            .background(backgroundColor)
            .cornerRadius(AdaptiveSize.scale(12))
        }
        .disabled(isAnswered)
    }
}

