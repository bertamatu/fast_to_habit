import SwiftUI
import UIKit

/// Fasting timer main screen
/// Features: Timer, start/stop, progress tracking
/// [Rule: Code Organization, Documentation, State Management]
struct FastView: View {
    
    // MARK: - State
    
    @AppStorage("fastingSelectedHours") private var storedGoalHours: Double = 16
    @StateObject private var sessionStore = FastSessionStore()
    @State private var currentTime = Date()
    @State private var timer: Timer?
    @State private var selectedPreset: FastPreset = .sixteenEight
    @State private var customDurationHours: Double = 16
    @State private var showingPresetPicker = false
    @State private var showingCustomPresetSheet = false
    @State private var showingCompletionSheet = false
    @State private var completionNote: String = ""
    @State private var selectedHistorySession: FastSession?
    @State private var pendingOutcome: FastSession.Outcome = .onTime
    
    // MARK: - Computed Properties
    
    /// Currently active fasting session if any
    private var activeSession: FastSession? {
        sessionStore.activeSession
    }
    /// Check if currently fasting
    private var isFasting: Bool {
        activeSession != nil
    }
    
    /// Calculate elapsed time in seconds
    private var elapsedSeconds: TimeInterval {
        guard let session = activeSession else { return 0 }
        return currentTime.timeIntervalSince(session.startDate)
    }
    
    /// Calculate progress (0.0 to 1.0)
    private var progress: Double {
        guard let session = activeSession else { return 0 }
        let goalSeconds = session.goalDurationHours * 3600
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
                    
                    // Active Fast Details
                    if isFasting {
                        activeFastDetails
                    }
                    
                    // History Section
                    if !sessionStore.history.isEmpty {
                        historySection
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
                    }
                )
            }
            .sheet(isPresented: $showingCompletionSheet) {
                CompleteFastSheet(
                    outcome: pendingOutcome,
                    durationText: elapsedTimeString,
                    goalText: "\(Int(activeSession?.goalDurationHours ?? selectedGoalHours))h",
                    remainingText: pendingOutcome == .early ? remainingTimeString : nil,
                    note: $completionNote,
                    onCancel: {
                        showingCompletionSheet = false
                        completionNote = ""
                    },
                    onComplete: {
                        confirmEndFast()
                    }
                )
            }
            .sheet(item: $selectedHistorySession) { session in
                FastHistoryDetailSheet(session: session)
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
            if let session = activeSession {
                HStack {
                    Text("Goal:")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    Text("\(Int(session.goalDurationHours))h")
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
    
    /// Active fast details card
    @ViewBuilder
    private var activeFastDetails: some View {
        if let session = activeSession {
            activeFastCard(for: session)
        } else {
            EmptyView()
        }
    }

    /// Helper to render active fast card content
    private func activeFastCard(for session: FastSession) -> some View {
        Card(title: "Current Fast") {
            VStack(spacing: Constants.Spacing.medium) {
                HStack {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Started")
                            .font(.caption)
                            .foregroundColor(.secondary)
                        Text(session.startDate, style: .time)
                            .font(.subheadline)
                            .fontWeight(.medium)
                    }
                    Spacer()
                    VStack(alignment: .trailing, spacing: 4) {
                        Text("Ends")
                            .font(.caption)
                            .foregroundColor(.secondary)
                        Text(session.expectedEndDate, style: .time)
                            .font(.subheadline)
                            .fontWeight(.semibold)
                    }
                }
                
                HStack {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Progress")
                            .font(.caption)
                            .foregroundColor(.secondary)
                        Text("\(Int(progress * 100))%")
                            .font(.subheadline)
                            .fontWeight(.medium)
                            .foregroundColor(.brandPrimary)
                    }
                    Spacer()
                    VStack(alignment: .trailing, spacing: 4) {
                        Text("Elapsed")
                            .font(.caption)
                            .foregroundColor(.secondary)
                        Text(elapsedTimeString)
                            .font(.subheadline)
                            .fontWeight(.medium)
                    }
                }
            }
        }
    }

    /// History list section
    private var historySection: some View {
        Card(title: "Fast History") {
            VStack(spacing: Constants.Spacing.small) {
                ForEach(sessionStore.history.prefix(5)) { session in
                    Button {
                        selectedHistorySession = session
                    } label: {
                        historyRow(for: session)
                    }
                    .buttonStyle(.plain)
                    if session.id != sessionStore.history.prefix(5).last?.id {
                        Divider()
                    }
                }
                if sessionStore.history.count > 5 {
                    Text("Showing 5 of \(sessionStore.history.count) fasts")
                        .font(.caption)
                        .foregroundColor(.secondary)
                        .padding(.top, Constants.Spacing.small)
                }
            }
        }
    }

    private func historyRow(for session: FastSession) -> some View {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        let durationHours = session.elapsedSeconds / 3600
        return HStack {
            VStack(alignment: .leading, spacing: 4) {
                HStack(spacing: Constants.Spacing.small) {
                    Text(session.preset == .custom ? "Custom" : session.preset.displayName)
                        .font(.subheadline)
                        .fontWeight(.semibold)
                    outcomeBadge(for: session)
                }
                
                if let completion = session.completionDate {
                    Text(formatter.string(from: completion))
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                if let note = session.note, !note.isEmpty {
                    Text(note)
                        .font(.caption)
                        .foregroundColor(.secondary)
                        .lineLimit(1)
                }
            }
            Spacer()
            Text(formattedHours(durationHours))
                .font(.subheadline)
                .fontWeight(.medium)
        }
    }

    private func summaryStat(title: String, value: String) -> some View {
        VStack(spacing: 4) {
            Text(value)
                .font(.headline)
                .fontWeight(.semibold)
            Text(title)
                .font(.caption)
                .foregroundColor(.secondary)
        }
        .frame(maxWidth: .infinity)
    }
    
    private func outcomeBadge(for session: FastSession) -> some View {
        Text(session.outcome == .extended ? "Extended" : session.outcome == .onTime ? "On Goal" : "Early")
            .font(.caption2)
            .fontWeight(.semibold)
            .padding(.horizontal, 6)
            .padding(.vertical, 2)
            .background(outcomeColor(for: session.outcome).opacity(0.18))
            .foregroundColor(outcomeColor(for: session.outcome))
            .cornerRadius(8)
    }
    
    private func outcomeColor(for outcome: FastSession.Outcome) -> Color {
        switch outcome {
        case .extended:
            return .brandPrimary
        case .onTime:
            return .green
        case .early:
            return .orange
        }
    }
    
    // MARK: - Computed Strings
    
    /// Format start time
    private var startTimeString: String {
        guard let session = activeSession else { return "--" }
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        return formatter.string(from: session.startDate)
    }
    
    /// Calculate remaining time
    private var remainingTimeString: String {
        guard let session = activeSession else { return "Start a fast to see remaining time" }
        let goalSeconds = session.goalDurationHours * 3600
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
        let startDate = Date()
        let session = FastSession(
            preset: selectedPreset,
            startDate: startDate,
            goalDurationHours: selectedGoalHours,
            status: .active
        )
        sessionStore.start(session: session)
        storedGoalHours = selectedGoalHours
        currentTime = startDate
        startTimer()
    }
    
    /// End fasting
    private func endFast() {
        guard let session = activeSession else { return }
        completionNote = ""
        let actualSeconds = Date().timeIntervalSince(session.startDate)
        let goalSeconds = session.goalDurationHours * 3600
        if actualSeconds >= goalSeconds {
            let extendedThreshold = goalSeconds * 1.1
            pendingOutcome = actualSeconds >= extendedThreshold ? .extended : .onTime
        } else {
            pendingOutcome = .early
        }
        showingCompletionSheet = true
    }
    
    /// Confirm completion of fast and persist note
    private func confirmEndFast() {
        sessionStore.completeActiveSession(
            note: completionNote.isEmpty ? nil : completionNote,
            outcome: pendingOutcome
        )
        showingCompletionSheet = false
        completionNote = ""
        stopTimer()
    }
    
    /// Start timer for updates
    private func startTimer() {
        guard timer == nil else { return }
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
        if let session = activeSession {
            if session.preset != .custom {
                selectedPreset = session.preset
                customDurationHours = session.preset.defaultDurationHours
            } else {
                selectedPreset = .custom
                customDurationHours = session.goalDurationHours
            }
        } else if let matchedPreset = FastPreset.allCases.first(where: { $0 != .custom && $0.defaultDurationHours == storedGoalHours }) {
            selectedPreset = matchedPreset
            customDurationHours = matchedPreset.defaultDurationHours
        } else {
            selectedPreset = .custom
            customDurationHours = max(storedGoalHours, 1)
        }
    }

    /// Display title based on preset selection
    private var presetDisplayTitle: String {
        if selectedPreset == .custom {
            return "\(Int(selectedGoalHours))h"
        }
        return selectedPreset.displayName
    }

    /// Format hours nicely for summary cards
    private func formattedHours(_ hours: Double) -> String {
        guard hours > 0 else { return "--" }
        if hours >= 10 {
            return "\(Int(hours))h"
        }
        return String(format: "%.1fh", hours)
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

/// Detail sheet rendering a completed fast history entry
/// [Rule: Documentation]
struct FastHistoryDetailSheet: View {
    @Environment(\.dismiss) private var dismiss
    let session: FastSession
    
    private var durationHours: Double {
        session.elapsedSeconds / 3600
    }
    
    private var startDate: Date { session.startDate }
    private var endDate: Date { session.completionDate ?? session.expectedEndDate }
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: Constants.Spacing.large) {
                    summarySection
                    noteSection
                }
                .padding(Constants.Spacing.large)
            }
            .navigationTitle("Fast Details")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Done") {
                        dismiss()
                    }
                }
            }
        }
    }
    
    private var summarySection: some View {
        VStack(alignment: .leading, spacing: Constants.Spacing.medium) {
            Text(session.preset == .custom ? "Custom Fast" : session.preset.displayName)
                .font(.title3)
                .fontWeight(.semibold)
            
            detailRow(title: "Duration", value: formattedHours(durationHours))
            detailRow(title: "Started", value: startDate.formatted(date: .abbreviated, time: .shortened))
            detailRow(title: "Completed", value: endDate.formatted(date: .abbreviated, time: .shortened))
            detailRow(title: "Goal", value: "\(Int(session.goalDurationHours))h")
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.cardBackground)
        )
    }
    
    @ViewBuilder
    private var noteSection: some View {
        if let note = session.note, !note.isEmpty {
            VStack(alignment: .leading, spacing: Constants.Spacing.small) {
                Text("Note")
                    .font(.headline)
                Text(note)
                    .font(.bodyRegular)
                    .foregroundColor(.primary)
            }
        } else {
            VStack(alignment: .leading, spacing: Constants.Spacing.small) {
                Text("No notes added")
                    .font(.headline)
                    .foregroundColor(.secondary)
                Text("Capture reflections when ending a fast to see them here.")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
        }
    }
    
    private func detailRow(title: String, value: String) -> some View {
        HStack {
            Text(title)
                .font(.subheadline)
                .foregroundColor(.secondary)
            Spacer()
            Text(value)
                .font(.subheadline)
                .fontWeight(.medium)
        }
    }
    
    private func formattedHours(_ hours: Double) -> String {
        if hours >= 10 {
            return "\(Int(hours))h"
        }
        return String(format: "%.1fh", hours)
    }
}

/// Sheet presented when ending a fast to capture notes
/// [Rule: Documentation, Forms]
struct CompleteFastSheet: View {
    @Environment(\.dismiss) private var dismiss
    let outcome: FastSession.Outcome
    let durationText: String
    let goalText: String
    let remainingText: String?
    @Binding var note: String
    let onCancel: () -> Void
    let onComplete: () -> Void
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: Constants.Spacing.large) {
                VStack(alignment: .leading, spacing: Constants.Spacing.small) {
                    Text(headerTitle)
                        .font(.title3)
                        .fontWeight(.semibold)
                    Text(headerMessage)
                        .font(.bodyRegular)
                        .foregroundColor(.secondary)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
                summaryChips
                
                reflectionSection
                
                Spacer()
            }
            .padding(Constants.Spacing.large)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button(cancelTitle) {
                        onCancel()
                        dismiss()
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button(confirmTitle) {
                        onComplete()
                        dismiss()
                    }
                    .font(.headline)
                }
            }
        }
    }
    
    private var cancelTitle: String {
        outcome == .early ? "Keep Fasting" : "Cancel"
    }
    
    private var confirmTitle: String {
        outcome == .early ? "End Anyway" : "Save"
    }
    
    private var headerTitle: String {
        switch outcome {
        case .extended:
            return "Amazing Commitment! 🔥"
        case .onTime:
            return "Fast Complete 🎉"
        case .early:
            return "End Fast Early?"
        }
    }
    
    private var headerMessage: String {
        switch outcome {
        case .extended:
            return "You went beyond your goal. Take a moment to celebrate this win!"
        case .onTime:
            return "Great job hitting your fasting goal. Capture how you feel while it's fresh."
        case .early:
            return "You're ending ahead of schedule. It's okay—listen to your body. Want to keep fasting a bit longer?"
        }
    }
    
    private var summaryChips: some View {
        VStack(spacing: Constants.Spacing.small) {
            HStack {
                summaryChip(title: "Duration", value: durationText)
                summaryChip(title: "Goal", value: goalText)
            }
            if outcome == .early, let remainingText {
                summaryChip(title: "Time Left", value: remainingText)
            }
        }
    }
    
    private var reflectionSection: some View {
        VStack(alignment: .leading, spacing: Constants.Spacing.small) {
            Text(outcome == .early ? "What will you try next?" : "Reflection")
                .font(.headline)
            TextEditor(text: $note)
                .frame(minHeight: 120)
                .padding(12)
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color.secondary.opacity(0.08))
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color.secondary.opacity(0.12), lineWidth: 1)
                )
        }
    }
    
    private func summaryChip(title: String, value: String) -> some View {
        VStack(spacing: 6) {
            Text(value)
                .font(.headline)
                .fontWeight(.semibold)
            Text(title)
                .font(.caption)
                .foregroundColor(.secondary)
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.brandPrimary.opacity(0.1))
        )
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
