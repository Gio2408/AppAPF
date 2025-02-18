import SwiftUI

struct ErrorsView: View {
    @EnvironmentObject var errorManager: ErrorManager
    
    var body: some View {
        NavigationView {
            ZStack {
                // Light green background for a more playful look
                Color(red: 0.4, green: 0.6, blue: 0.2)
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    
                    List {
                        ForEach(errorManager.errors) { error in
                            HStack(spacing: 12) {
                                Image(systemName: "exclamationmark.triangle.fill")
                                    .foregroundColor(.yellow)
                                    .font(.title)
                                
                                VStack(alignment: .leading, spacing: 8) {
                                    Text(error.question)
                                        .font(.system(size: 20, weight: .bold, design: .rounded))
                                        .foregroundColor(.white)
                                    
                                    Text("✅ Correct answer: \(error.correctAnswer)")
                                        .foregroundColor(.green)
                                        .font(.system(size: 18, design: .rounded))
                                    
                                    Text("❌ Your answer: \(error.userAnswer)")
                                        .foregroundColor(.red)
                                        .font(.system(size: 18, design: .rounded))
                                }
                            }
                            .padding()
                            .background(Color.white.opacity(0.9))
                            .cornerRadius(20)
                            .shadow(color: .gray.opacity(0.3), radius: 4, x: 0, y: 2)
                        }
                        .onDelete { indices in
                            errorManager.errors.remove(atOffsets: indices)
                            errorManager.saveErrors()
                        }
                    }
                    .listStyle(PlainListStyle()) // Keeps the appearance without borders
                    .padding(.horizontal, 16)
                }
            }
            .navigationTitle("Errors")
            .onAppear {
                errorManager.loadErrors()
            }
        }
    }
}
