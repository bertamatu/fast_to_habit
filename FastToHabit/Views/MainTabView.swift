import SwiftUI

/// Main tab view with bottom navigation
/// Features: 4 tabs - Fast, Planning, Progress, Settings
/// [Rule: Code Organization, Navigation, Accessibility]
struct MainTabView: View {
    
    // MARK: - State
    
    @State private var selectedTab = 0
    
    // MARK: - Body
    
    var body: some View {
        TabView(selection: $selectedTab) {
            // Fast Tab
            FastView()
                .tabItem {
                    Label("Fast", systemImage: "flame.fill")
                }
                .tag(0)
            
            // Planning Tab
            PlanningView()
                .tabItem {
                    Label("Planning", systemImage: "calendar")
                }
                .tag(1)
            
            // Progress Tab
            ProgressView()
                .tabItem {
                    Label("Progress", systemImage: "chart.line.uptrend.xyaxis")
                }
                .tag(2)
            
            // Settings Tab
            SettingsView()
                .tabItem {
                    Label("Settings", systemImage: "gearshape.fill")
                }
                .tag(3)
        }
        .accentColor(.brandPrimary)
    }
}

// MARK: - SwiftUI Previews

#if DEBUG
#Preview("Main Tab View") {
    MainTabView()
}

#Preview("Main Tab View - Dark") {
    MainTabView()
        .preferredColorScheme(.dark)
}
#endif
