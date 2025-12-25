
import SwiftUI

struct SoundsView: View {
    @ObservedObject var viewModel: SoundsViewModel
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                if viewModel.soundFiles.isEmpty {
                    VStack(spacing: 16) {
                        Text("No sounds found")
                            .font(.headline)
                            .foregroundColor(.secondary)
                        Text("Add sound files to the Sounds folder")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else {
                    ScrollView {
                        LazyVStack(spacing: AdaptiveSize.spacing(12)) {
                            ForEach(viewModel.soundFiles) { soundFile in
                                SoundButton(
                                    soundFile: soundFile,
                                    viewModel: viewModel
                                )
                            }
                        }
                        .adaptivePadding(.all, 12)
                    }
                }
                
                if !viewModel.isSoundEnabled {
                    Text("🔇 Sound disabled in settings")
                        .font(.caption)
                        .foregroundColor(.secondary)
                        .padding(.bottom, 20)
                }
            }
            .navigationTitle("Sounds")
        }
    }
}

struct SoundButton: View {
    let soundFile: SoundsAnimal
    @ObservedObject var viewModel: SoundsViewModel
    
    private var isPlaying: Bool {
        viewModel.isPlaying(soundFile)
    }
    
    private var isPaused: Bool {
        viewModel.isPaused(soundFile)
    }
    
    private var isActive: Bool {
        isPlaying || isPaused
    }
    
    var body: some View {
        HStack(spacing: AdaptiveSize.spacing(12)) {
            Text(soundFile.emoji)
                .font(.system(size: AdaptiveSize.fontSize(32)))
            
            Text(soundFile.displayName)
                .font(.system(size: AdaptiveSize.fontSize(16), weight: .semibold))
                .foregroundColor(.primary)
                .lineLimit(1)
                .minimumScaleFactor(0.8)
            
            Spacer()
            
            Button(action: {
                if isPaused {
                    viewModel.resumeSound()
                } else if isPlaying {
                    viewModel.pauseSound()
                } else {
                    viewModel.playSound(from: soundFile)
                }
            }) {
                Image(systemName: isPaused ? "play.fill" : (isPlaying ? "pause.fill" : "speaker.wave.2.fill"))
                    .font(.system(size: AdaptiveSize.fontSize(18)))
                    .foregroundColor(isActive ? .accentColor : .secondary)
                    .frame(width: AdaptiveSize.scale(28), height: AdaptiveSize.scale(28))
            }
            .disabled(!viewModel.isSoundEnabled)
            
            if isActive {
                Button(action: {
                    viewModel.stopSound()
                }) {
                    Image(systemName: "stop.fill")
                        .font(.system(size: AdaptiveSize.fontSize(18)))
                        .foregroundColor(.red)
                        .frame(width: AdaptiveSize.scale(28), height: AdaptiveSize.scale(28))
                }
                .disabled(!viewModel.isSoundEnabled)
            }
        }
        .frame(maxWidth: .infinity)
        .adaptivePadding(.all, 12)
        .background(isActive ? Color.accentColor.opacity(0.15) : Color(.systemGray5))
        .cornerRadius(AdaptiveSize.scale(12))
        .opacity(viewModel.isSoundEnabled ? 1.0 : 0.6)
    }
}

#Preview {
    SoundsView(viewModel: SoundsViewModel())
}

