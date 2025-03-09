import SwiftUI

struct RevengeStep: Identifiable {
    let id = UUID()
    let title: String
    let description: String
    let icon: String
    let tips: [String]
}

struct RevengePlanView: View {
    @State private var selectedStep: RevengeStep?
    @State private var showingDetail = false
    
    let steps = [
        RevengeStep(
            title: "Level Up Your Life",
            description: "The best revenge is massive success. Focus on personal growth and self-improvement.",
            icon: "arrow.up.circle.fill",
            tips: [
                "Start a new fitness routine",
                "Learn a new skill or hobby",
                "Update your wardrobe",
                "Focus on career advancement",
                "Travel and explore new places"
            ]
        ),
        RevengeStep(
            title: "Social Media Strategy",
            description: "Show your best life without being obvious about it.",
            icon: "camera.fill",
            tips: [
                "Post your achievements naturally",
                "Share happy moments with friends",
                "Never mention them directly",
                "Keep it classy and authentic",
                "Let your success speak for itself"
            ]
        ),
        RevengeStep(
            title: "Emotional Growth",
            description: "Transform pain into power and become the best version of yourself.",
            icon: "heart.fill",
            tips: [
                "Practice self-care daily",
                "Start journaling",
                "Meditate and stay centered",
                "Surround yourself with positivity",
                "Set and achieve new goals"
            ]
        ),
        RevengeStep(
            title: "Professional Success",
            description: "Focus on your career and financial independence.",
            icon: "briefcase.fill",
            tips: [
                "Pursue that promotion",
                "Start a side business",
                "Network strategically",
                "Invest in yourself",
                "Build your personal brand"
            ]
        )
    ]
    
    var body: some View {
        ScrollView {
            VStack(spacing: 25) {
                headerSection
                
                ForEach(steps) { step in
                    RevengeStepCard(step: step)
                        .onTapGesture {
                            selectedStep = step
                            showingDetail = true
                        }
                }
                
                motivationalQuote
            }
            .padding()
        }
        .sheet(isPresented: $showingDetail) {
            if let step = selectedStep {
                StepDetailView(step: step)
            }
        }
    }
    
    private var headerSection: some View {
        VStack(spacing: 15) {
            Text("Your Glow-Up Game Plan")
                .font(.system(size: 28, weight: .bold))
                .foregroundColor(.purple)
            
            Text("Remember: Success is the best revenge. Let's focus on making you the best version of yourself!")
                .font(.subheadline)
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
        }
    }
    
    private var motivationalQuote: some View {
        VStack(spacing: 15) {
            Text("\"The best revenge is not to be like your enemy.\"")
                .font(.system(size: 20, weight: .medium))
                .italic()
                .foregroundColor(.purple)
            
            Text("- Marcus Aurelius")
                .font(.subheadline)
                .foregroundColor(.gray)
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(Color.purple.opacity(0.1))
        .cornerRadius(15)
    }
}

struct RevengeStepCard: View {
    let step: RevengeStep
    
    var body: some View {
        HStack {
            Image(systemName: step.icon)
                .font(.system(size: 30))
                .foregroundColor(.purple)
                .frame(width: 60)
            
            VStack(alignment: .leading, spacing: 8) {
                Text(step.title)
                    .font(.headline)
                
                Text(step.description)
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .lineLimit(2)
            }
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .foregroundColor(.gray)
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(15)
        .shadow(radius: 2)
    }
}

struct StepDetailView: View {
    let step: RevengeStep
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    HStack {
                        Image(systemName: step.icon)
                            .font(.system(size: 40))
                            .foregroundColor(.purple)
                        
                        Text(step.title)
                            .font(.title)
                            .bold()
                    }
                    .padding(.bottom)
                    
                    Text(step.description)
                        .font(.body)
                        .padding(.bottom)
                    
                    Text("Action Steps")
                        .font(.headline)
                    
                    ForEach(step.tips, id: \.self) { tip in
                        TipRow(text: tip)
                    }
                    
                    motivationalSection
                }
                .padding()
            }
            .navigationBarItems(trailing: Button("Done") {
                presentationMode.wrappedValue.dismiss()
            })
        }
    }
    
    private var motivationalSection: some View {
        VStack(alignment: .leading, spacing: 15) {
            Text("Remember")
                .font(.headline)
                .padding(.top)
            
            Text("This journey is about becoming the best version of yourself. Focus on your growth, and let karma handle the rest.")
                .font(.subheadline)
                .foregroundColor(.gray)
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.purple.opacity(0.1))
        .cornerRadius(15)
    }
}

struct TipRow: View {
    let text: String
    
    var body: some View {
        HStack(alignment: .top) {
            Image(systemName: "star.fill")
                .font(.system(size: 12))
                .foregroundColor(.purple)
                .padding(.top, 4)
            
            Text(text)
                .font(.subheadline)
        }
        .padding(.vertical, 4)
    }
} 