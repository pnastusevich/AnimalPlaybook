import SwiftUI

struct GameResultRow: View {
    let icon: String
    let label: String
    let value: String
    
    var body: some View {
        HStack {
            Text(icon)
                .font(.system(size: AdaptiveSize.fontSize(24)))
            
            Text(label)
                .font(.system(size: AdaptiveSize.fontSize(16), weight: .medium))
                .foregroundColor(.primary)
            
            Spacer()
            
            Text(value)
                .font(.system(size: AdaptiveSize.fontSize(20), weight: .bold))
                .foregroundColor(.accentColor)
        }
    }
}

