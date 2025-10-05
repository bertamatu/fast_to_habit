import SwiftUI

/// Fasting timer main screen
/// Features: Timer, start/stop, progress tracking
/// [Rule: Code Organization, Documentation, State Management]
struct FastView: View {
    
    // MARK: - State
    
    @AppStorage("fastingStartTime") private var fastingStartTime: Double = 0
    @AppStorage("fastingGoalHours") private var fastingGoalHours: Double = 16
    @State private var currentTime = Date()
    @State private var timer: Timer?
    
    // MARK: - Computed Properties
    
    /// Check if currently fasting
    private var isFasting: Bool {
        fastingStartTime > 0
    }
    
    /// Calculate elapsed time in seconds
    private var elapsedSeconds: TimeInterval {
        guard isFasting else { return 0 }
        return currentTime.timeIntervalSince(Date(timeIntervalSince1970: fastingStartTime))
    }
    
    /// Calculate progress (0.0 to 1.0)
    private var progress: Double {
        let goalSeconds = fastingGoalHours * 3600
        return min(elapsedSeconds / goalSeconds, 1.0)
    }
    
    /// Format elapsed time as string
    private var elapsedTimeString: String {
        let hours = Int(elapsedSeconds) / 3600
        let minutes = (Int(elapsedSeconds) % 3600) / 60
        return String(format: "%02d:%02d", hours, minutes)
    }
    
    // MARK: - Body
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: Constants.Spacing.extraLarge) {
                    // Timer Circle
                    timerCircle
                    
                    // Status Info
                    statusInfo
                    
                    // Action Button
                    actionButton
                    
                    // Quick Stats
                    if isFasting {
                        quickStats
                    }
                }
                .padding(Constants.Spacing.large)
            }
            .background(Color.backgroundPrimary)
            .navigationTitle("Fast")
            .onAppear {
                startTimer()
            }
            .onDisappear {
                stopTimer()
            }
        }
    }
    
    // MARK: - Subviews
    
    /// Timer circle with progress
    private var timerCircle: some View {
        ZStack {
            // Background circle
            Circle()
                .stroke(Color.gray.opacity(0.2), lineWidth: 20)
                .frame(width: 250, height: 250)
            
            // Progress circle
            Circle()
                .trim(from: 0, to: progress)
                .stroke(
                    isFasting ? Color.brandPrimary : Color.gray.opacity(0.3),
                    style: StrokeStyle(lineWidth: 20, lineCap: .round)
                )
                .frame(width: 250, height: 250)
                .rotationEffect(.degrees(-90))
                .animation(.easeInOut, value: progress)
            
            // Time display
            VStack(spacing: Constants.Spacing.small) {
                Text(elapsedTimeString)
                    .font(.system(size: 56, weight: .bold, design: .rounded))
                    .foregroundColor(.primary)
                
                Text(isFasting ? "Fasting" : "Not Fasting")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
        }
        .padding(.top, Constants.Spacing.large)
    }
    
    /// Status information
    private var statusInfo: some View {
        VStack(spacing: Constants.Spacing.small) {
            if isFasting {
                HStack {
                    Text("Goal:")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    Text("\(Int(fastingGoalHours))h")
                        .font(.headline)
                        .foregroundColor(.primary)
                }
                
                HStack {
                    Text("Remaining:")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    Text(remainingTimeString)
                        .font(.headline)
                        .foregroundColor(progress >= 1.0 ? .success : .primary)
                }
            } else {
                Text("Ready to start your fast")
                    .font(.headline)
                    .foregroundColor(.secondary)
            }
        }
    }
    
    /// Action button (Start/Stop)
    private var actionButton: some View {
        Group {
            if isFasting {
                Button(action: endFast) {
                    HStack {
                        Image(systemName: "stop.fill")
                        Text("End Fast")
                            .fontWeight(.semibold)
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.red)
                    .foregroundColor(.white)
                    .cornerRadius(12)
                }
            } else {
                PrimaryButton(
                    title: "Start Fasting",
                    action: startFast,
                    icon: "play.fill"
                )
            }
        }
        .padding(.horizontal, Constants.Spacing.large)
    }
    
    /// Quick stats when fasting
    private var quickStats: some View {
        Card(title: "Current Fast") {
            VStack(spacing: Constants.Spacing.medium) {
                HStack {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Started")
                            .font(.caption)
                            .foregroundColor(.secondary)
                        Text(startTimeString)
                            .font(.subheadline)
                            .fontWeight(.medium)
                    }
                    
                    Spacer()
                    
                    VStack(alignment: .trailing, spacing: 4) {
                        Text("Progress")
                            .font(.caption)
                            .foregroundColor(.secondary)
                        Text("\(Int(progress * 100))%")
                            .font(.subheadline)
                            .fontWeight(.medium)
                            .foregroundColor(.brandPrimary)
                    }
                }
            }
        }
    }
    
    // MARK: - Computed Strings
    
    /// Format start time
    private var startTimeString: String {
        let date = Date(timeIntervalSince1970: fastingStartTime)
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }
    
    /// Calculate remaining time
    private var remainingTimeString: String {
        let goalSeconds = fastingGoalHours * 3600
        let remaining = max(0, goalSeconds - elapsedSeconds)
        let hours = Int(remaining) / 3600
        let minutes = (Int(remaining) % 3600) / 60
        
        if remaining <= 0 {
            return "Goal reached! 🎉"
        }
        return String(format: "%dh %dm", hours, minutes)
    }
    
    // MARK: - Actions
    
    /// Start fasting
    private func startFast() {
        fastingStartTime = Date().timeIntervalSince1970
    }
    
    /// End fasting
    private func endFast() {
        // TODO: Save fast to history
        fastingStartTime = 0
    }
    
    /// Start timer for updates
    private func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            currentTime = Date()
        }
    }
    
    /// Stop timer
    private func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
}

// MARK: - SwiftUI Previews

#if DEBUG
#Preview("Fast View") {
    FastView()
}

#Preview("Fast View - Dark") {
    FastView()
        .preferredColorScheme(.dark)
}
#endif
