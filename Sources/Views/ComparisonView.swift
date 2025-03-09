import SwiftUI
import PhotosUI

struct ComparisonView: View {
    @State private var yourImage: UIImage?
    @State private var theirImage: UIImage?
    @State private var yourLinkedInURL = ""
    @State private var theirLinkedInURL = ""
    @State private var showingImagePicker = false
    @State private var isSelectingYourPhoto = true
    @State private var analysisResult: String?
    @State private var confidenceScore: Double = 0
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                Text("Who's Better?")
                    .font(.system(size: 28, weight: .bold))
                    .foregroundColor(.purple)
                
                // Your Photo Section
                VStack {
                    Text("Your Photo")
                        .font(.headline)
                    
                    if let image = yourImage {
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFit()
                            .frame(height: 200)
                            .cornerRadius(10)
                    } else {
                        Button(action: {
                            isSelectingYourPhoto = true
                            showingImagePicker = true
                        }) {
                            ZStack {
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(Color.purple.opacity(0.1))
                                    .frame(height: 200)
                                
                                Image(systemName: "plus.circle.fill")
                                    .font(.system(size: 30))
                                    .foregroundColor(.purple)
                            }
                        }
                    }
                    
                    TextField("Your LinkedIn Profile URL", text: $yourLinkedInURL)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.horizontal)
                }
                
                // Their Photo Section
                VStack {
                    Text("Their Photo")
                        .font(.headline)
                    
                    if let image = theirImage {
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFit()
                            .frame(height: 200)
                            .cornerRadius(10)
                    } else {
                        Button(action: {
                            isSelectingYourPhoto = false
                            showingImagePicker = true
                        }) {
                            ZStack {
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(Color.purple.opacity(0.1))
                                    .frame(height: 200)
                                
                                Image(systemName: "plus.circle.fill")
                                    .font(.system(size: 30))
                                    .foregroundColor(.purple)
                            }
                        }
                    }
                    
                    TextField("Their LinkedIn Profile URL", text: $theirLinkedInURL)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.horizontal)
                }
                
                Button(action: analyzeComparison) {
                    Text("Analyze")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.purple)
                        .cornerRadius(10)
                }
                .padding(.horizontal)
                
                if let result = analysisResult {
                    VStack(spacing: 10) {
                        Text("Analysis Result")
                            .font(.headline)
                        
                        Text(result)
                            .multilineTextAlignment(.center)
                            .padding()
                            .background(Color.purple.opacity(0.1))
                            .cornerRadius(10)
                        
                        ProgressView(value: confidenceScore, total: 1.0)
                            .progressViewStyle(LinearProgressViewStyle(tint: .purple))
                            .padding(.horizontal)
                        
                        Text("\(Int(confidenceScore * 100))% Confidence")
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                }
            }
            .padding()
        }
        .sheet(isPresented: $showingImagePicker) {
            ImagePicker(image: isSelectingYourPhoto ? $yourImage : $theirImage)
        }
    }
    
    private func analyzeComparison() {
        // Mock analysis for now - will integrate with AI services
        analysisResult = "Based on our advanced AI analysis, you're definitely the better catch! Your profile shows more authenticity and charm. Remember, true beauty comes from within! 💜"
        confidenceScore = 0.85
    }
}

struct ImagePicker: UIViewControllerRepresentable {
    @Binding var image: UIImage?
    @Environment(\.presentationMode) var presentationMode
    
    func makeUIViewController(context: Context) -> PHPickerViewController {
        var config = PHPickerConfiguration()
        config.filter = .images
        let picker = PHPickerViewController(configuration: config)
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, PHPickerViewControllerDelegate {
        let parent: ImagePicker
        
        init(_ parent: ImagePicker) {
            self.parent = parent
        }
        
        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            parent.presentationMode.wrappedValue.dismiss()
            
            guard let provider = results.first?.itemProvider else { return }
            
            if provider.canLoadObject(ofClass: UIImage.self) {
                provider.loadObject(ofClass: UIImage.self) { image, _ in
                    DispatchQueue.main.async {
                        self.parent.image = image as? UIImage
                    }
                }
            }
        }
    }
} 