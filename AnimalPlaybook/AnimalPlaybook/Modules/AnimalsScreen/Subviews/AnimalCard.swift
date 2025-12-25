

import SwiftUI

struct AnimalCard: View {
    let animal: Animal
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack(spacing: AdaptiveSize.spacing(8)) {
                Text(animal.emoji)
                    .font(.system(size: AdaptiveSize.fontSize(50)))
                
                Text(animal.name)
                    .font(.system(size: AdaptiveSize.fontSize(16), weight: .semibold))
                    .foregroundColor(.primary)
                    .lineLimit(1)
                    .minimumScaleFactor(0.8)
                
                Text(animal.category.rawValue)
                    .font(.system(size: AdaptiveSize.fontSize(11)))
                    .foregroundColor(.secondary)
                    .adaptivePadding(.horizontal, 6)
                    .adaptivePadding(.vertical, 3)
                    .background(Color(.systemGray5))
                    .cornerRadius(AdaptiveSize.scale(6))
            }
            .frame(maxWidth: .infinity)
            .adaptivePadding(.all, 12)
            .background(Color(.systemBackground))
            .cornerRadius(AdaptiveSize.scale(12))
            .shadow(color: Color.black.opacity(0.1), radius: AdaptiveSize.scale(4), x: 0, y: AdaptiveSize.scale(2))
        }
        .buttonStyle(.plain)
    }
}
