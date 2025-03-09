import SwiftUI

struct ScoreCard: Identifiable {
    let id = UUID()
    let title: String
    let grade: String
    let description: String
    let color: Color
}

struct ScoreAnalysisView: View {
    @State private var showingDetail = false
    @State private var selectedCard: ScoreCard?
    
    let scoreCards = [
        ScoreCard(
            title: "You",
            grade: "A",
            description: "Strong, resilient, and authentic. You've shown remarkable growth and emotional intelligence throughout this journey.",
            color: .purple
        ),
        ScoreCard(
            title: "Your Ex",
            grade: "C+",
            description: "Poor communication, lack of emotional maturity, and questionable decision-making skills.",
            color: .red
        ),
        ScoreCard(
            title: "The Situation",
            grade: "B-",
            description: "A challenging experience that revealed true colors and opened doors for personal growth.",
            color: .blue
        )
    ]
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                Text("Relationship Analysis")
                    .font(.system(size: 28, weight: .bold))
                    .foregroundColor(.purple)
                    .padding(.top)
                
                Text("AI-Powered Score Breakdown")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                
                ForEach(scoreCards) { card in
                    ScoreCardView(card: card)
                        .onTapGesture {
                            selectedCard = card
                            showingDetail = true
                        }
                }
                
                overallAnalysisSection
            }
            .padding()
        }
        .sheet(isPresented: $showingDetail) {
            if let card = selectedCard {
                ScoreDetailView(card: card)
            }
        }
    }
    
    private var overallAnalysisSection: some View {
        VStack(alignment: .leading, spacing: 15) {
            Text("Overall Analysis")
                .font(.headline)
                .padding(.top)
            
            Text("Based on our comprehensive AI analysis, you're clearly the winner in this situation! Your emotional intelligence and personal growth set you apart. Remember:")
                .foregroundColor(.gray)
            
            VStack(alignment: .leading, spacing: 10) {
                AnalysisPoint(text: "You've shown remarkable resilience")
                AnalysisPoint(text: "Your authenticity shines through")
                AnalysisPoint(text: "You're ready for better things ahead")
                AnalysisPoint(text: "Your growth journey is inspiring")
            }
            .padding(.vertical)
        }
        .padding()
        .background(Color.purple.opacity(0.1))
        .cornerRadius(15)
    }
}

struct ScoreCardView: View {
    let card: ScoreCard
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 8) {
                Text(card.title)
                    .font(.headline)
                
                Text(card.description)
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .lineLimit(2)
            }
            
            Spacer()
            
            Text(card.grade)
                .font(.system(size: 40, weight: .bold))
                .foregroundColor(card.color)
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(15)
        .shadow(radius: 2)
    }
}

struct ScoreDetailView: View {
    let card: ScoreCard
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    HStack {
                        Text(card.title)
                            .font(.largeTitle)
                            .bold()
                        
                        Spacer()
                        
                        Text(card.grade)
                            .font(.system(size: 60, weight: .bold))
                            .foregroundColor(card.color)
                    }
                    
                    Text(card.description)
                        .font(.body)
                    
                    DetailSection(title: "Strengths", points: getStrengths())
                    DetailSection(title: "Areas for Growth", points: getGrowthAreas())
                    DetailSection(title: "Key Insights", points: getInsights())
                }
                .padding()
            }
            .navigationBarItems(trailing: Button("Done") {
                presentationMode.wrappedValue.dismiss()
            })
        }
    }
    
    private func getStrengths() -> [String] {
        switch card.title {
        case "You":
            return [
                "Strong emotional intelligence",
                "Ability to grow from experiences",
                "Authentic self-expression",
                "Resilience in difficult situations"
            ]
        case "Your Ex":
            return [
                "N/A - Growth opportunities ahead",
                "Room for improvement in all areas",
                "Potential for learning from mistakes"
            ]
        default:
            return [
                "Learning opportunity",
                "Character revealing moment",
                "Growth catalyst"
            ]
        }
    }
    
    private func getGrowthAreas() -> [String] {
        switch card.title {
        case "You":
            return [
                "Continue building self-confidence",
                "Trust your intuition more",
                "Maintain healthy boundaries"
            ]
        case "Your Ex":
            return [
                "Communication skills",
                "Emotional maturity",
                "Decision-making ability",
                "Relationship responsibility"
            ]
        default:
            return [
                "Processing emotions",
                "Moving forward positively",
                "Learning from experience"
            ]
        }
    }
    
    private func getInsights() -> [String] {
        switch card.title {
        case "You":
            return [
                "You're stronger than you know",
                "This experience will make you wiser",
                "Better things are coming your way",
                "Your worth isn't defined by others"
            ]
        case "Your Ex":
            return [
                "Their loss, not yours",
                "Their actions reflect on them",
                "They missed out on someone special",
                "Growth requires self-awareness"
            ]
        default:
            return [
                "Every ending is a new beginning",
                "Time reveals true characters",
                "Growth comes from challenges",
                "Trust the journey"
            ]
        }
    }
}

struct DetailSection: View {
    let title: String
    let points: [String]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(title)
                .font(.headline)
            
            ForEach(points, id: \.self) { point in
                HStack(alignment: .top) {
                    Image(systemName: "circle.fill")
                        .font(.system(size: 8))
                        .padding(.top, 6)
                    
                    Text(point)
                        .font(.subheadline)
                }
            }
        }
        .padding(.top)
    }
}

struct AnalysisPoint: View {
    let text: String
    
    var body: some View {
        HStack {
            Image(systemName: "checkmark.circle.fill")
                .foregroundColor(.purple)
            Text(text)
                .font(.subheadline)
        }
    }
} 