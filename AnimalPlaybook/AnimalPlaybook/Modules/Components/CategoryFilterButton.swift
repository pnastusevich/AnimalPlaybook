
import SwiftUI

struct CategoryFilterButton: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.system(size: AdaptiveSize.fontSize(13), weight: .medium))
                .foregroundColor(isSelected ? .white : .primary)
                .adaptivePadding(.horizontal, 14)
                .adaptivePadding(.vertical, 6)
                .background(isSelected ? Color.accentColor : Color(.systemGray5))
                .cornerRadius(AdaptiveSize.scale(18))
        }
    }
}

