import SwiftUI

struct GameRuleRow: View {
    let icon: String
    let text: String
    
    var body: some View {
        HStack(spacing: AdaptiveSize.spacing(12)) {
            Text(icon)
                .font(.system(size: AdaptiveSize.fontSize(20)))
            Text(text)
                .font(.system(size: AdaptiveSize.fontSize(15)))
                .foregroundColor(.primary)
            Spacer()
        }
    }
}

