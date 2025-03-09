import SwiftUI

struct Message: Identifiable {
    let id = UUID()
    let content: String
    let isUser: Bool
    let timestamp: Date
}

struct ChatStoryView: View {
    @State private var messages: [Message] = []
    @State private var newMessage = ""
    @State private var showingPrompts = true
    
    let suggestedPrompts = [
        "How did you two meet?",
        "When did things start going wrong?",
        "What was the breaking point?",
        "How did you find out about them?",
        "How are you feeling now?"
    ]
    
    var body: some View {
        VStack {
            ScrollView {
                LazyVStack(spacing: 15) {
                    if showingPrompts {
                        promptsView
                    }
                    
                    ForEach(messages) { message in
                        MessageBubble(message: message)
                    }
                }
                .padding()
            }
            
            HStack {
                TextField("Type your message...", text: $newMessage)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal)
                
                Button(action: sendMessage) {
                    Image(systemName: "arrow.up.circle.fill")
                        .font(.system(size: 30))
                        .foregroundColor(.purple)
                }
                .padding(.trailing)
            }
            .padding(.vertical, 10)
            .background(Color(.systemBackground))
            .shadow(radius: 1)
        }
    }
    
    private var promptsView: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Start your story...")
                .font(.headline)
                .padding(.horizontal)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 10) {
                    ForEach(suggestedPrompts, id: \.self) { prompt in
                        Button(action: { selectPrompt(prompt) }) {
                            Text(prompt)
                                .padding(10)
                                .background(Color.purple.opacity(0.1))
                                .cornerRadius(15)
                        }
                    }
                }
                .padding(.horizontal)
            }
        }
        .padding(.vertical)
    }
    
    private func selectPrompt(_ prompt: String) {
        newMessage = prompt
        sendMessage()
    }
    
    private func sendMessage() {
        guard !newMessage.isEmpty else { return }
        
        let userMessage = Message(content: newMessage, isUser: true, timestamp: Date())
        messages.append(userMessage)
        showingPrompts = false
        
        // Simulate AI response
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            let response = generateResponse(to: newMessage)
            let aiMessage = Message(content: response, isUser: false, timestamp: Date())
            messages.append(aiMessage)
        }
        
        newMessage = ""
    }
    
    private func generateResponse(to message: String) -> String {
        // Mock AI responses - will integrate with actual AI service
        let responses = [
            "I understand how difficult this must be for you. Remember that you're strong and capable of getting through this.",
            "That sounds really challenging. Want to tell me more about how you're feeling?",
            "You deserve someone who truly values and appreciates you. This is their loss, not yours.",
            "It's completely normal to feel this way. Let's focus on your healing and growth.",
            "You're handling this with such grace. Remember, the best revenge is living your best life!"
        ]
        
        return responses.randomElement() ?? "I'm here to listen and support you."
    }
}

struct MessageBubble: View {
    let message: Message
    
    var body: some View {
        HStack {
            if message.isUser { Spacer() }
            
            Text(message.content)
                .padding(15)
                .background(message.isUser ? Color.purple : Color.gray.opacity(0.2))
                .foregroundColor(message.isUser ? .white : .primary)
                .cornerRadius(20)
                .frame(maxWidth: 280, alignment: message.isUser ? .trailing : .leading)
            
            if !message.isUser { Spacer() }
        }
    }
}
