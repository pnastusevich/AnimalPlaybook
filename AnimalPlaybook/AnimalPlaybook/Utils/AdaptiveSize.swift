import SwiftUI

struct AdaptiveSize {
    static func scale(_ base: CGFloat) -> CGFloat {
        let screenWidth = UIScreen.main.bounds.width
        let baseWidth: CGFloat = 390
        let minWidth: CGFloat = 375
        
        let scaleFactor: CGFloat
        if screenWidth <= minWidth {
            scaleFactor = 0.9
        } else if screenWidth <= baseWidth {
            scaleFactor = 0.9 + (screenWidth - minWidth) / (baseWidth - minWidth) * 0.2
        } else {
            scaleFactor = min(1.1 + (screenWidth - baseWidth) / baseWidth * 0.1, 1.2)
        }
        
        return base * scaleFactor
    }
    
    static func spacing(_ base: CGFloat) -> CGFloat {
        return scale(base)
    }
    
    static func fontSize(_ base: CGFloat) -> CGFloat {
        return scale(base)
    }
    
    static func padding(_ base: CGFloat) -> CGFloat {
        return scale(base)
    }
}

extension View {
    func adaptivePadding(_ edges: Edge.Set = .all, _ length: CGFloat) -> some View {
        self.padding(edges, AdaptiveSize.padding(length))
    }
    
    func adaptiveSpacing(_ length: CGFloat) -> some View {
        self.padding(.vertical, AdaptiveSize.spacing(length))
    }
}

