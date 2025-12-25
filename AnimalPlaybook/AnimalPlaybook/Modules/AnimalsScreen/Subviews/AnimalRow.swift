

import SwiftUI

struct AnimalRow: View {
    let animal: Animal
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: AdaptiveSize.spacing(12)) {
                Text(animal.emoji)
                    .font(.system(size: AdaptiveSize.fontSize(32)))
                
                VStack(alignment: .leading, spacing: AdaptiveSize.spacing(3)) {
                    Text(animal.name)
                        .font(.system(size: AdaptiveSize.fontSize(16), weight: .semibold))
                        .foregroundColor(.primary)
                    
                    Text(animal.category.rawValue)
                        .font(.system(size: AdaptiveSize.fontSize(12)))
                        .foregroundColor(.secondary)
                }
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .font(.system(size: AdaptiveSize.fontSize(12)))
                    .foregroundColor(.secondary)
            }
            .adaptivePadding(.vertical, 8)
            .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
    }
}

