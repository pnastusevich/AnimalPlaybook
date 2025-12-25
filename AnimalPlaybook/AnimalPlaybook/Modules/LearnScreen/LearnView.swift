
import SwiftUI

struct LearnView: View {
    @StateObject private var viewModel = LearnViewModel()
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 12) {
                        CategoryFilterButton(
                            title: "All",
                            isSelected: viewModel.selectedCategory == nil
                        ) {
                            viewModel.filterByCategory(nil)
                        }
                        
                        ForEach(AnimalCategory.allCases) { category in
                            CategoryFilterButton(
                                title: category.rawValue,
                                isSelected: viewModel.selectedCategory == category
                            ) {
                                viewModel.filterByCategory(category)
                            }
                        }
                    }
                    .adaptivePadding(.horizontal, 16)
                    .adaptivePadding(.vertical, 10)
                }
                .background(Color(.systemBackground))
                
                Divider()
                
                ScrollView {
                    LazyVStack(spacing: AdaptiveSize.spacing(12)) {
                        ForEach(viewModel.filteredFacts) { fact in
                            FactCard(fact: fact)
                        }
                    }
                    .adaptivePadding(.all, 12)
                }
            }
            .navigationTitle("Learn")
        }
    }
}

struct FactCard: View {
    let fact: AnimalFact
    
    var body: some View {
        HStack(alignment: .top, spacing: AdaptiveSize.spacing(12)) {
            Image(systemName: "lightbulb.fill")
                .font(.system(size: AdaptiveSize.fontSize(20)))
                .foregroundColor(.yellow)
                .adaptivePadding(.top, 3)
            
            Text(fact.text)
                .font(.system(size: AdaptiveSize.fontSize(15)))
                .foregroundColor(.primary)
                .fixedSize(horizontal: false, vertical: true)
            
            Spacer()
        }
        .adaptivePadding(.all, 12)
        .background(Color(.systemGray5))
        .cornerRadius(AdaptiveSize.scale(12))
    }
}

#Preview {
    LearnView()
}

