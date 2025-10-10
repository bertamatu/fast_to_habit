import SwiftUI

/// Circular progress ring for water intake tracking
/// [Rule: Documentation, Styling & Layout]
struct WaterProgressRing: View {
    let progress: Double
    let totalGlasses: Int
    let consumedGlasses: Int
    
    private let lineWidth: CGFloat = 16
    private let ringSize: CGFloat = 180
    
    var body: some View {
        ZStack {
            // Background ring
            Circle()
                .stroke(Color.gray.opacity(0.15), lineWidth: lineWidth)
                .frame(width: ringSize, height: ringSize)
            
            // Progress ring
            Circle()
                .trim(from: 0, to: progress)
                .stroke(
                    LinearGradient(
                        colors: [
                            Color(red: 0.29, green: 0.56, blue: 0.89), // #4A90E2
                            Color(red: 0.31, green: 0.79, blue: 0.91)  // #50C9E9
                        ],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    ),
                    style: StrokeStyle(lineWidth: lineWidth, lineCap: .round)
                )
                .frame(width: ringSize, height: ringSize)
                .rotationEffect(.degrees(-90))
                .animation(.spring(response: 0.6, dampingFraction: 0.8), value: progress)
            
            // Center content
            VStack(spacing: 4) {
                // Glass count
                HStack(alignment: .firstTextBaseline, spacing: 4) {
                    Text("\(consumedGlasses)")
                        .font(.system(size: 48, weight: .bold, design: .rounded))
                        .foregroundColor(.primary)
                    Text("/\(totalGlasses)")
                        .font(.system(size: 24, weight: .semibold, design: .rounded))
                        .foregroundColor(.secondary)
                }
                
                // Label
                Text("glasses")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
        }
    }
}

#if DEBUG
#Preview("Water Progress Ring - Empty") {
    WaterProgressRing(progress: 0, totalGlasses: 8, consumedGlasses: 0)
        .padding()
}

#Preview("Water Progress Ring - Half") {
    WaterProgressRing(progress: 0.5, totalGlasses: 8, consumedGlasses: 4)
        .padding()
}

#Preview("Water Progress Ring - Complete") {
    WaterProgressRing(progress: 1.0, totalGlasses: 8, consumedGlasses: 8)
        .padding()
}
#endif
