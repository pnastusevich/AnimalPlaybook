import SwiftUI

struct AnimalsView: View {
    @ObservedObject var viewModel: AnimalsViewModel
    @ObservedObject var settingsViewModel: SettingsViewModel
    let coordinator: MainTabCoordinator
    
    @State private var selectedCategory: AnimalCategory?
    
    var filteredAnimals: [Animal] {
        viewModel.filterAnimals(by: selectedCategory)
    }
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 12) {
                        CategoryFilterButton(
                            title: "All",
                            isSelected: selectedCategory == nil
                        ) {
                            selectedCategory = nil
                        }
                        
                        ForEach(AnimalCategory.allCases) { category in
                            CategoryFilterButton(
                                title: category.rawValue,
                                isSelected: selectedCategory == category
                            ) {
                                selectedCategory = category
                            }
                        }
                    }
                    .adaptivePadding(.horizontal, 16)
                    .adaptivePadding(.vertical, 10)
                }
                .background(Color(.systemBackground))
                
                Divider()
                
                if settingsViewModel.currentDisplayStyle == .cards {
                    cardsView
                } else {
                    listView
                }
            }
            .navigationTitle("Animals")
            .sheet(item: $viewModel.selectedAnimal) { animal in
                AnimalDetailView(animal: animal, viewModel: viewModel, coordinator: coordinator)
            }
        }
    }
    
    private var cardsView: some View {
        ScrollView {
            LazyVGrid(columns: [
                GridItem(.flexible(), spacing: AdaptiveSize.spacing(12)),
                GridItem(.flexible(), spacing: AdaptiveSize.spacing(12))
            ], spacing: AdaptiveSize.spacing(12)) {
                ForEach(filteredAnimals) { animal in
                    AnimalCard(animal: animal) {
                        viewModel.selectedAnimal = animal
                    }
                }
            }
            .adaptivePadding(.all, 12)
        }
    }
    
    private var listView: some View {
        List(filteredAnimals) { animal in
            AnimalRow(animal: animal) {
                viewModel.selectedAnimal = animal
            }
        }
        .listStyle(.plain)
    }
}


#Preview {
    let coordinator = MainTabCoordinator()
    AnimalsView(
        viewModel: coordinator.animalsViewModel,
        settingsViewModel: coordinator.settingsViewModel,
        coordinator: coordinator
    )
}

