import SwiftUI

/// Top navigation bar with month selector dropdown and settings button
/// Displays current month/year and allows navigation through available months
/// [Rule: Code Organization, Documentation]
struct MonthSelectorView: View {
    
    // MARK: - Properties
    
    @Binding var selectedDate: Date
    let onSettingsTapped: () -> Void
    
    // MARK: - Body
    
    var body: some View {
        HStack {
            // Month selector with dropdown of all months
            Menu {
                ForEach(availableMonths, id: \.self) { date in
                    Button {
                        selectedDate = date
                    } label: {
                        HStack {
                            Text(date.formatted(.dateTime.month(.wide).year()))
                            if Calendar.current.isDate(date, equalTo: selectedDate, toGranularity: .month) {
                                Image(systemName: "checkmark")
                            }
                        }
                    }
                }
            } label: {
                HStack(spacing: 8) {
                    Text(selectedDate.formatted(.dateTime.month(.wide).year()))
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.primary)
                    
                    Image(systemName: "chevron.down")
                        .font(.subheadline)
                        .foregroundColor(.primary)
                }
            }
            
            Spacer()
            
            // Settings button
            Button {
                onSettingsTapped()
            } label: {
                Image(systemName: "gearshape.fill")
                    .font(.title2)
                    .foregroundColor(.brandPrimary)
            }
        }
        .padding(.horizontal, Constants.Spacing.medium)
        .padding(.vertical, Constants.Spacing.small)
        .background(Color.backgroundPrimary)
    }
    
    // MARK: - Computed Properties
    
    /// Computed property to generate available months (6 months back, current, 6 months forward)
    private var availableMonths: [Date] {
        let calendar = Calendar.current
        let today = Date.now
        var months: [Date] = []
        
        // Generate months from 6 months ago to 6 months in the future
        for monthOffset in -6...6 {
            if let month = calendar.date(byAdding: .month, value: monthOffset, to: today),
               let firstDayOfMonth = calendar.date(from: calendar.dateComponents([.year, .month], from: month)) {
                months.append(firstDayOfMonth)
            }
        }
        
        return months
    }
}

// MARK: - SwiftUI Previews

#if DEBUG
#Preview("Month Selector") {
    MonthSelectorView(
        selectedDate: .constant(Date.now),
        onSettingsTapped: {}
    )
}
#endif
