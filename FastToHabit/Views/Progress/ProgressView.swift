import SwiftUI

/// Progress tracking screen
/// Features: Weight tracking, fasting statistics, recent activity
/// [Rule: Code Organization, Documentation, Data Visualization]
struct ProgressView: View {
    
    // MARK: - State
    
    @AppStorage("userWeight") private var currentWeight: String = ""
    @AppStorage("userGoalWeight") private var goalWeight: String = ""
    @State private var weightEntries: [WeightEntry] = []
    @State private var showingAddWeight = false
    @State private var showingAddGoalWeight = false
    
    // Computed property to check if we have any data
    private var hasData: Bool {
        !currentWeight.isEmpty || !weightEntries.isEmpty
    }

    /// Goal weight column with add prompt when missing
    private var goalWeightColumn: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text("Goal Weight")
                    .font(.caption)
                    .foregroundColor(.secondary)
                
                if !goalWeight.isEmpty {
                    Text("\(goalWeight) kg")
                        .font(.titleMedium)
                        .fontWeight(.semibold)
                        .foregroundColor(.brandPrimary)
                } else {
                    Button {
                        showingAddGoalWeight = true
                    } label: {
                        HStack(spacing: 6) {
                            Image(systemName: "plus.circle.fill")
                                .font(.title3)
                            Text("Add Goal")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                        }
                        .foregroundColor(.brandPrimary)
                    }
                }
            }
            
            Spacer()
            
            if !goalWeight.isEmpty {
                goalInlineStatus
            } else {
                statusIndicator(title: "Status", detail: "Set", color: .success, icon: "checkmark.circle.fill")
            }
        }
    }

    /// Inline status chip showing goal progress snapshot
    private var goalInlineStatus: some View {
        VStack(alignment: .trailing, spacing: 4) {
            if let diff = weightDifference {
                let isGoalMet = diff <= 0
                Text(isGoalMet ? "Goal Reached" : "Still to Go")
                    .font(.caption)
                    .foregroundColor(.secondary)
                HStack(spacing: 4) {
                    Image(systemName: isGoalMet ? "checkmark.seal.fill" : "arrow.down")
                        .font(.caption)
                    Text(isGoalMet ? "Great progress" : String(format: "%.1f kg", diff))
                        .font(.subheadline)
                        .fontWeight(.semibold)
                }
                .foregroundColor(isGoalMet ? .success : .brandPrimary)
            } else {
                statusIndicator(title: "Goal", detail: "Not set", color: .secondary, icon: "exclamationmark.triangle")
            }
        }
    }

    /// Info reminder chip promoting settings updates
    private var infoReminder: some View {
        HStack(spacing: 8) {
            Image(systemName: "info.circle")
                .foregroundColor(.brandPrimary)
            Text("Keep your stats fresh from Settings")
                .font(.caption)
                .foregroundColor(.secondary)
        }
    }

    /// Inline progress snapshot for quick glance
    private var progressSummaryChip: some View {
        Group {
            if weightProgress > 0 && !goalWeight.isEmpty {
                HStack(spacing: 8) {
                    Image(systemName: "chart.bar.fill")
                        .foregroundColor(.brandPrimary)
                        .font(.caption)
                    Text(String(format: "%d%% to goal", Int(weightProgress * 100)))
                        .font(.caption)
                        .fontWeight(.semibold)
                        .foregroundColor(.brandPrimary)
                }
                .padding(.vertical, 6)
                .padding(.horizontal, 10)
                .background(Color.brandPrimary.opacity(0.12))
                .clipShape(Capsule())
            }
        }
    }

    /// Convenience builder for status chip
    private func statusIndicator(title: String, detail: String, color: Color, icon: String) -> some View {
        VStack(alignment: .trailing, spacing: 4) {
            Text(title)
                .font(.caption)
                .foregroundColor(.secondary)
            HStack(spacing: 4) {
                Image(systemName: icon)
                    .font(.caption)
                Text(detail)
                    .font(.subheadline)
            }
            .foregroundColor(color)
        }
    }
    
    // Calculate weight difference
    private var weightDifference: Double? {
        guard let current = Double(currentWeight),
              let goal = Double(goalWeight) else { return nil }
        return current - goal
    }
    
    // Calculate progress percentage
    private var weightProgress: Double {
        guard let current = Double(currentWeight),
              let goal = Double(goalWeight),
              goal > 0 else { return 0 }
        
        // Assuming starting weight was higher, calculate how close to goal
        let difference = current - goal
        if difference <= 0 {
            return 1.0 // Goal reached or exceeded
        }
        // This is simplified - in real app, you'd track starting weight
        return max(0, min(1.0, 1.0 - (difference / current)))
    }
    
    // MARK: - Body
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: Constants.Spacing.large) {
                    if hasData {
                        // Weight Progress Section
                        weightProgressSection
                        
                        // Weight Chart
                        if weightEntries.count >= 2 {
                            weightChartSection
                        }
                        
                        // Weight Goal Section
                        if !goalWeight.isEmpty {
                            weightGoalSection
                        }
                    } else {
                        // Empty State
                        emptyStateView
                    }
                }
                .padding(Constants.Spacing.medium)
            }
            .background(Color.backgroundPrimary)
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button {
                        showingAddWeight = true
                    } label: {
                        Image(systemName: "plus.circle.fill")
                            .foregroundColor(.brandPrimary)
                    }
                }
            }
            .sheet(isPresented: $showingAddWeight) {
                AddWeightView(onSave: loadWeightEntries)
            }
            .sheet(isPresented: $showingAddGoalWeight) {
                AddGoalWeightSheet(
                    currentGoalWeight: goalWeight,
                    onSave: { newGoal in
                        goalWeight = newGoal
                    }
                )
            }
            .onAppear {
                loadWeightEntries()
            }
        }
    }
    
    // MARK: - Sections
    
    /// Weight progress card with chart
    private var weightProgressSection: some View {
        Card(title: "Weight Tracking") {
            VStack(spacing: Constants.Spacing.medium) {
                if !currentWeight.isEmpty {
                    // Current vs goal weight display
                    HStack(alignment: .top) {
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Current Weight")
                                .font(.caption)
                                .foregroundColor(.secondary)
                            Text("\(currentWeight) kg")
                                .font(.titleLarge)
                                .fontWeight(.bold)
                                .foregroundColor(.primary)
                        }
                        
                        Spacer()
                        
                        goalWeightColumn
                    }
                    
                    Divider()
                    
                    HStack(spacing: 12) {
                        progressSummaryChip
                        Spacer()
                        infoReminder
                    }
                } else {
                    // No weight set
                    VStack(spacing: Constants.Spacing.medium) {
                        Image(systemName: "scalemass")
                            .font(.system(size: 50))
                            .foregroundColor(.secondary)
                        
                        Text("No Weight Recorded")
                            .font(.headline)
                            .foregroundColor(.primary)
                        
                        Text("Add your weight in Settings or during onboarding to track your progress")
                            .font(.caption)
                            .foregroundColor(.secondary)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, Constants.Spacing.small)
                }
            }
        }
    }
    
    /// Weight goal section with progress
    private var weightGoalSection: some View {
        Card(title: "Weight Goal") {
            VStack(spacing: Constants.Spacing.medium) {
                // Goal info
                HStack {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Target Weight")
                            .font(.caption)
                            .foregroundColor(.secondary)
                        
                        Text("\(goalWeight) kg")
                            .font(.titleMedium)
                            .fontWeight(.bold)
                            .foregroundColor(.primary)
                    }
                    
                    Spacer()
                    
                    if let diff = weightDifference {
                        VStack(alignment: .trailing, spacing: 4) {
                            Text("To Go")
                                .font(.caption)
                                .foregroundColor(.secondary)
                            
                            HStack(spacing: 4) {
                                if diff > 0 {
                                    Image(systemName: "arrow.down")
                                        .font(.caption)
                                    Text(String(format: "%.1f kg", diff))
                                        .font(.subheadline)
                                        .fontWeight(.semibold)
                                } else {
                                    Image(systemName: "checkmark.circle.fill")
                                        .font(.caption)
                                    Text("Goal Reached!")
                                        .font(.subheadline)
                                        .fontWeight(.semibold)
                                }
                            }
                            .foregroundColor(diff > 0 ? .brandPrimary : .success)
                        }
                    }
                }
                
                // Progress bar
                if weightProgress > 0 {
                    Divider()
                    
                    VStack(alignment: .leading, spacing: 8) {
                        HStack {
                            Text("Progress to Goal")
                                .font(.caption)
                                .foregroundColor(.secondary)
                            Spacer()
                            Text("\(Int(weightProgress * 100))%")
                                .font(.caption)
                                .fontWeight(.semibold)
                                .foregroundColor(.brandPrimary)
                        }
                        
                        GeometryReader { geometry in
                            ZStack(alignment: .leading) {
                                RoundedRectangle(cornerRadius: 4)
                                    .fill(Color.gray.opacity(0.2))
                                    .frame(height: 8)
                                
                                RoundedRectangle(cornerRadius: 4)
                                    .fill(Color.brandPrimary)
                                    .frame(width: geometry.size.width * weightProgress, height: 8)
                            }
                        }
                        .frame(height: 8)
                    }
                }
            }
        }
    }
    
    /// Weight chart section with gradient line chart
    private var weightChartSection: some View {
        Card(title: "Weight Trend") {
            VStack(spacing: Constants.Spacing.medium) {
                // Line chart with gradient
                GeometryReader { geometry in
                    let chartData = Array(weightEntries.prefix(10).reversed())
                    let maxWeight = chartData.map { $0.weight }.max() ?? 100
                    let minWeight = chartData.map { $0.weight }.min() ?? 50
                    let range = maxWeight - minWeight
                    let adjustedRange = range < 5 ? 5 : range
                    let chartHeight = geometry.size.height - 40
                    let chartWidth = geometry.size.width - 45
                    let leftPadding: CGFloat = 45
                    
                    ZStack(alignment: .topLeading) {
                        // Grid lines
                        VStack(spacing: 0) {
                            ForEach(0..<5) { i in
                                HStack(spacing: 0) {
                                    Text(String(format: "%.0f", maxWeight - (adjustedRange / 4) * Double(i)))
                                        .font(.caption2)
                                        .foregroundColor(.secondary.opacity(0.6))
                                        .frame(width: 35, alignment: .trailing)
                                        .padding(.trailing, 5)
                                    
                                    Rectangle()
                                        .fill(Color.gray.opacity(0.15))
                                        .frame(height: 0.5)
                                }
                                Spacer()
                            }
                        }
                        
                        // Gradient fill under line
                        Path { path in
                            guard !chartData.isEmpty else { return }
                            
                            // Start from bottom left
                            path.move(to: CGPoint(x: leftPadding, y: chartHeight))
                            
                            // Draw line through data points
                            for (index, entry) in chartData.enumerated() {
                                let x = chartWidth * CGFloat(index) / CGFloat(max(chartData.count - 1, 1)) + leftPadding
                                let normalizedValue = (entry.weight - (maxWeight - adjustedRange)) / adjustedRange
                                let y = chartHeight * (1 - normalizedValue)
                                
                                if index == 0 {
                                    path.addLine(to: CGPoint(x: x, y: y))
                                } else {
                                    path.addLine(to: CGPoint(x: x, y: y))
                                }
                            }
                            
                            // Close path at bottom right
                            if let lastIndex = chartData.indices.last {
                                let lastX = chartWidth * CGFloat(lastIndex) / CGFloat(max(chartData.count - 1, 1)) + leftPadding
                                path.addLine(to: CGPoint(x: lastX, y: chartHeight))
                            }
                            path.closeSubpath()
                        }
                        .fill(
                            LinearGradient(
                                colors: [
                                    Color.brandPrimary.opacity(0.3),
                                    Color.brandPrimary.opacity(0.05)
                                ],
                                startPoint: .top,
                                endPoint: .bottom
                            )
                        )
                        
                        // Line
                        Path { path in
                            for (index, entry) in chartData.enumerated() {
                                let x = chartWidth * CGFloat(index) / CGFloat(max(chartData.count - 1, 1)) + leftPadding
                                let normalizedValue = (entry.weight - (maxWeight - adjustedRange)) / adjustedRange
                                let y = chartHeight * (1 - normalizedValue)
                                
                                if index == 0 {
                                    path.move(to: CGPoint(x: x, y: y))
                                } else {
                                    path.addLine(to: CGPoint(x: x, y: y))
                                }
                            }
                        }
                        .stroke(Color.brandPrimary, style: StrokeStyle(lineWidth: 2.5, lineCap: .round, lineJoin: .round))
                        
                        // Data points with hover effect
                        ForEach(Array(chartData.enumerated()), id: \.element.id) { index, entry in
                            let x = chartWidth * CGFloat(index) / CGFloat(max(chartData.count - 1, 1)) + leftPadding
                            let normalizedValue = (entry.weight - (maxWeight - adjustedRange)) / adjustedRange
                            let y = chartHeight * (1 - normalizedValue)
                            
                            ZStack {
                                // Outer circle (white background)
                                Circle()
                                    .fill(Color.white)
                                    .frame(width: 10, height: 10)
                                    .shadow(color: Color.brandPrimary.opacity(0.3), radius: 2, x: 0, y: 1)
                                
                                // Inner circle (brand color)
                                Circle()
                                    .fill(Color.brandPrimary)
                                    .frame(width: 6, height: 6)
                            }
                            .position(x: x, y: y)
                        }
                    }
                }
                .frame(height: 200)
                
                Text("Last \(min(weightEntries.count, 10)) entries")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
        }
    }
    
    /// Weight history section
    private var weightHistorySection: some View {
        Card(title: "Weight History") {
            VStack(spacing: Constants.Spacing.small) {
                ForEach(weightEntries.prefix(5)) { entry in
                    HStack {
                        VStack(alignment: .leading, spacing: 2) {
                            Text(entry.date, style: .date)
                                .font(.subheadline)
                                .fontWeight(.medium)
                            
                            if let note = entry.note {
                                Text(note)
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                            }
                        }
                        
                        Spacer()
                        
                        Text(String(format: "%.1f kg", entry.weight))
                            .font(.headline)
                            .foregroundColor(.brandPrimary)
                    }
                    .padding(.vertical, 4)
                    
                    if entry.id != weightEntries.prefix(5).last?.id {
                        Divider()
                    }
                }
                
                if weightEntries.count > 5 {
                    Text("Showing 5 of \(weightEntries.count) entries")
                        .font(.caption)
                        .foregroundColor(.secondary)
                        .padding(.top, 8)
                }
            }
        }
    }
    
    // MARK: - Actions
    
    /// Load weight entries from storage
    private func loadWeightEntries() {
        weightEntries = WeightEntryManager.loadEntries()
    }
    
    /// Empty state when no data
    private var emptyStateView: some View {
        VStack(spacing: Constants.Spacing.large) {
            Spacer()
            
            EmptyStateView(
                icon: "scalemass",
                title: "No Weight Data Yet",
                message: "Add your weight in Settings or during onboarding to track your progress",
                actionTitle: "Go to Settings",
                action: {
                    // TODO: Navigate to Settings tab
                }
            )
            
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
}

// MARK: - SwiftUI Previews

#if DEBUG
#Preview("Progress View") {
    ProgressView()
}

#Preview("Progress View - Dark") {
    ProgressView()
        .preferredColorScheme(.dark)
}
#endif
