import SwiftUI

struct ContentView: View {
    @State private var selectedTab = 0
    
    var body: some View {
        TabView(selection: $selectedTab) {
            ComparisonView()
                .tabItem {
                    Image(systemName: "person.2.fill")
                    Text("Compare")
                }
                .tag(0)
            
            ChatStoryView()
                .tabItem {
                    Image(systemName: "message.fill")
                    Text("Your Story")
                }
                .tag(1)
            
            ScoreAnalysisView()
                .tabItem {
                    Image(systemName: "chart.bar.fill")
                    Text("Analysis")
                }
                .tag(2)
            
            RevengePlanView()
                .tabItem {
                    Image(systemName: "star.fill")
                    Text("Game Plan")
                }
                .tag(3)
        }
        .accentColor(.purple)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
} 