import SwiftUI
import UIKit

/// Fasting timer main screen
/// Features: Timer, start/stop, progress tracking
/// [Rule: Code Organization, Documentation, State Management]
struct FastView: View {
    
    // MARK: - State
    
    @AppStorage("fastingStartTime") private var fastingStartTime: Double = 0
    @AppStorage("fastingGoalHours") private var fastingGoalHours: Double = 16
    @State private var currentTime = Date()
    @State private var timer: Timer?
    @State private var selectedPreset: FastPreset = .sixteenEight
    @State private var customDurationHours: Double = 16
    @State private var showingPresetPicker = false
    @State private var showingCustomPresetSheet = false
    
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

    /// Goal hours determined by the selected preset or custom duration
    private var selectedGoalHours: Double {
        let duration = selectedPreset == .custom ? customDurationHours : selectedPreset.defaultDurationHours
        return max(duration, 1)
    }

    /// Expected finish time string for the current selection when not fasting
    private var selectedExpectedEndString: String {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        let endDate = Date().addingTimeInterval(selectedGoalHours * 3600)
        return formatter.string(from: endDate)
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

                    // Preset Summary
                    presetSummary
                    
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
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        guard !isFasting else { return }
                        showingPresetPicker = true
                        provideSelectionHaptic()
                    } label: {
                        Image(systemName: "slider.horizontal.3")
                    }
                    .disabled(isFasting)
                }
            }
            .onAppear {
                syncPresetSelection()
                startTimer()
            }
            .onDisappear {
                stopTimer()
            }
            .sheet(isPresented: $showingPresetPicker) {
                FastPresetSelectionSheet(
                    selectedPreset: selectedPreset,
                    customDurationHours: Int(max(customDurationHours, 1)),
                    onSelectPreset: { preset in
                        selectedPreset = preset
                        customDurationHours = preset.defaultDurationHours
                        provideSelectionHaptic()
                    },
                    onSelectCustom: {
                        showingCustomPresetSheet = true
                    }
                )
            }
            .sheet(isPresented: $showingCustomPresetSheet) {
                CustomFastDurationSheet(
                    initialDurationHours: Int(max(customDurationHours, 1)),
                    onSave: { hours in
                        customDurationHours = Double(hours)
                        selectedPreset = .custom
                        provideSelectionHaptic()
                    }
                )
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
                VStack(spacing: Constants.Spacing.small) {
                    Text(selectedPreset == .custom ? "Custom fast selected" : "Ready to start your fast")
                        .font(.headline)
                        .foregroundColor(.secondary)

                    HStack(spacing: 6) {
                        Text("Duration")
                            .font(.caption)
                            .foregroundColor(.secondary)
                        Text("\(Int(selectedGoalHours))h")
                            .font(.subheadline)
                            .fontWeight(.semibold)
                        Image(systemName: "arrow.forward")
                            .font(.caption)
                            .foregroundColor(.secondary)
                        Text(selectedExpectedEndString)
                            .font(.subheadline)
                            .fontWeight(.medium)
                    }
                    .foregroundColor(.secondary)
                }
            }
        }
    }

    /// Preset summary pill matching design reference
    private var presetSummary: some View {
        Button {
            guard !isFasting else { return }
            showingPresetPicker = true
            provideSelectionHaptic()
        } label: {
            HStack(spacing: Constants.Spacing.small) {
                Text(presetDisplayTitle)
                    .font(.subheadline)
                    .fontWeight(.semibold)
                Image(systemName: "pencil")
                    .font(.caption)
            }
            .padding(.vertical, 8)
            .padding(.horizontal, 14)
            .background(
                RoundedRectangle(cornerRadius: 18)
                    .fill(isFasting ? Color.gray.opacity(0.2) : Color.brandPrimary.opacity(0.12))
            )
            .overlay(
                RoundedRectangle(cornerRadius: 18)
                    .stroke(isFasting ? Color.gray.opacity(0.2) : Color.brandPrimary.opacity(0.35), lineWidth: 1)
            )
            .foregroundColor(isFasting ? .secondary : .primary)
        }
        .disabled(isFasting)
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
                    title: "Start \(Int(selectedGoalHours))h Fast",
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
        fastingGoalHours = selectedGoalHours
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

    /// Synchronize preset selection with persisted goal hours
    private func syncPresetSelection() {
        if let matchedPreset = FastPreset.allCases.first(where: { $0 != .custom && $0.defaultDurationHours == fastingGoalHours }) {
            selectedPreset = matchedPreset
            customDurationHours = matchedPreset.defaultDurationHours
        } else {
            selectedPreset = .custom
            customDurationHours = max(fastingGoalHours, 1)
        }
    }

    /// Display title based on preset selection
    private var presetDisplayTitle: String {
        if selectedPreset == .custom {
            return "\(Int(selectedGoalHours))h"
        }
        return selectedPreset.displayName
    }

    /// Provide subtle haptic feedback for preset selection
    private func provideSelectionHaptic() {
        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.impactOccurred()
    }
}

/// Sheet allowing users to configure a custom fasting duration
/// [Rule: Documentation, Forms]
struct CustomFastDurationSheet: View {
    
    // MARK: - Properties
    
    @Environment(\.dismiss) private var dismiss
    @State private var selectedHours: Int
    let onSave: (Int) -> Void
    
    private let hourRange = Array(1...48)
    
    // MARK: - Initializer
    
    init(initialDurationHours: Int, onSave: @escaping (Int) -> Void) {
        _selectedHours = State(initialValue: max(min(initialDurationHours, 48), 1))
        self.onSave = onSave
    }
    
    // MARK: - Body
    
    var body: some View {
        NavigationView {
            VStack(spacing: Constants.Spacing.large) {
                VStack(spacing: Constants.Spacing.small) {
                    Text("Custom Duration")
                        .font(.title3)
                        .fontWeight(.semibold)
                    Text("Choose how long you want to fast. You can adjust between 1 and 48 hours.")
                        .font(.bodyRegular)
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                }
                .padding(.top, Constants.Spacing.large)
                
                Picker("Hours", selection: $selectedHours) {
                    ForEach(hourRange, id: \.self) { hour in
                        Text("\(hour) hours")
                            .font(.headline)
                            .tag(hour)
                    }
                }
                .pickerStyle(.wheel)
                .frame(maxWidth: .infinity)
                
                Spacer()
            }
            .padding(.bottom, Constants.Spacing.large)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        onSave(selectedHours)
                        dismiss()
                    }
                    .font(.headline)
                }
            }
        }
    }
}

/// Sheet listing preset options for selection
/// [Rule: Documentation]
struct FastPresetSelectionSheet: View {
    @Environment(\.dismiss) private var dismiss
    let selectedPreset: FastPreset
    let customDurationHours: Int
    let onSelectPreset: (FastPreset) -> Void
    let onSelectCustom: () -> Void
    
    private var presets: [FastPreset] {
        FastPreset.allCases.filter { $0 != .custom }
    }
    
    var body: some View {
        NavigationView {
            List {
                Section("Popular Fasts") {
                    ForEach(presets, id: \.self) { preset in
                        Button {
                            onSelectPreset(preset)
                            dismiss()
                        } label: {
                            HStack {
                                VStack(alignment: .leading, spacing: 4) {
                                    Text(preset.displayName)
                                        .font(.headline)
                                    Text(preset.tagline)
                                        .font(.caption)
                                        .foregroundColor(.secondary)
                                }
                                Spacer()
                                if preset == selectedPreset {
                                    Image(systemName: "checkmark.circle.fill")
                                        .foregroundColor(.brandPrimary)
                                }
                            }
                        }
                    }
                }
                
                Section("Custom") {
                    Button {
                        onSelectCustom()
                        dismiss()
                    } label: {
                        HStack {
                            VStack(alignment: .leading, spacing: 4) {
                                Text("Custom Duration")
                                    .font(.headline)
                                Text("Current: \(customDurationHours)h")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                            }
                            Spacer()
                            if selectedPreset == .custom {
                                Image(systemName: "checkmark.circle.fill")
                                    .foregroundColor(.brandPrimary)
                            }
                            Image(systemName: "chevron.right")
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                    }
                }
            }
            .listStyle(.insetGrouped)
            .navigationTitle("Fasting Options")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Close") {
                        dismiss()
                    }
                }
            }
        }
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
