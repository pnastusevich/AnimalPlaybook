import SwiftUI

struct QuestionContentView: View {
    let question: GameQuestion
    let questionMode: QuestionMode
    let isPlayingSound: Bool
    let isSoundEnabled: Bool
    let onPlaySound: () -> Void
    let onStopSound: () -> Void
    
    var body: some View {
        Group {
            if questionMode == .image {
                VStack(spacing: AdaptiveSize.spacing(6)) {
                    Text(question.animal.emoji)
                        .font(.system(size: AdaptiveSize.fontSize(70)))
                    
                    Text("Who is this?")
                        .font(.system(size: AdaptiveSize.fontSize(20), weight: .medium))
                        .foregroundColor(.secondary)
                        .adaptivePadding(.top, 6)
                }
            } else {
                VStack(spacing: AdaptiveSize.spacing(18)) {
                    Button(action: {
                        if isPlayingSound {
                            onStopSound()
                        } else {
                            onPlaySound()
                        }
                    }) {
                        Image(systemName: isPlayingSound ? "stop.circle.fill" : "play.circle.fill")
                            .font(.system(size: AdaptiveSize.fontSize(60)))
                            .foregroundColor(isSoundEnabled ? .accentColor : Color(.systemGray3))
                    }
                    .disabled(!isSoundEnabled)
                    
                    Text("Listen to the sound")
                        .font(.system(size: AdaptiveSize.fontSize(20), weight: .medium))
                        .foregroundColor(.secondary)
                    
                    Text("Who is this?")
                        .font(.system(size: AdaptiveSize.fontSize(18)))
                        .foregroundColor(.secondary)
                }
            }
        }
    }
}

