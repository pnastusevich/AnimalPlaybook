
import SwiftUI

struct AnimalDetailView: View {
    let animal: Animal
    @ObservedObject var viewModel: AnimalsViewModel
    let coordinator: MainTabCoordinator
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: AdaptiveSize.spacing(20)) {
                    Text(animal.emoji)
                        .font(.system(size: AdaptiveSize.fontSize(100)))
                        .adaptivePadding(.top, 20)
                    
                    Text(animal.name)
                        .font(.system(size: AdaptiveSize.fontSize(28), weight: .bold))
                        .foregroundColor(.primary)
                    
                    Text(animal.category.rawValue)
                        .font(.system(size: AdaptiveSize.fontSize(18)))
                        .foregroundColor(.secondary)
                        .adaptivePadding(.horizontal, 14)
                        .adaptivePadding(.vertical, 6)
                        .background(Color(.systemGray5))
                        .cornerRadius(AdaptiveSize.scale(10))
                    
                    Text(animal.description)
                        .font(.system(size: AdaptiveSize.fontSize(16)))
                        .multilineTextAlignment(.center)
                        .foregroundColor(.primary)
                        .adaptivePadding(.horizontal, 20)
                        .adaptivePadding(.vertical, 14)
                        .background(Color(.systemGray5))
                        .cornerRadius(AdaptiveSize.scale(12))
                        .adaptivePadding(.horizontal, 16)
                    
                    Button(action: {
                        if viewModel.isPlayingSound(forAnimalName: animal.name) {
                            viewModel.stopSound()
                        } else {
                            viewModel.playSound(forAnimalName: animal.name)
                        }
                    }) {
                        HStack(spacing: AdaptiveSize.spacing(8)) {
                            Image(systemName: viewModel.isPlayingSound(forAnimalName: animal.name) ? "stop.fill" : "speaker.wave.2.fill")
                                .font(.system(size: AdaptiveSize.fontSize(18)))
                            Text(viewModel.isPlayingSound(forAnimalName: animal.name) ? "Stop Sound" : "Play Sound")
                                .font(.system(size: AdaptiveSize.fontSize(16), weight: .semibold))
                        }
                        .frame(maxWidth: .infinity)
                        .adaptivePadding(.all, 14)
                        .background(viewModel.isSoundEnabled ? Color.accentColor : Color(.systemGray4))
                        .foregroundColor(.white)
                        .cornerRadius(AdaptiveSize.scale(12))
                        .adaptivePadding(.horizontal, 16)
                    }
                    .disabled(!viewModel.isSoundEnabled)
                    .adaptivePadding(.bottom, 20)
                }
            }
            .navigationTitle("Details")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") {
                        if viewModel.isPlayingSound(forAnimalName: animal.name) {
                            viewModel.stopSound()
                        }
                        coordinator.showAnimalDetail(animal)
                        dismiss()
                    }
                }
            }
            .onDisappear {
                if viewModel.isPlayingSound(forAnimalName: animal.name) {
                    viewModel.stopSound()
                }
            }
        }
    }
}

