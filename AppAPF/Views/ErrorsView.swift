import SwiftUI

struct ErrorsView: View {
    @EnvironmentObject var errorManager: ErrorManager // Access to the errorManager object
    
    var body: some View {
        NavigationView {
            
            ZStack {
                // Sfondo verde chiaro per un look più giocoso
                Color(red: 0.65, green: 0.80, blue: 0.45)
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
                                    
                                    Text("✅ Risposta corretta: \(error.correctAnswer)")
                                        .foregroundColor(.green)
                                        .font(.system(size: 18, design: .rounded))
                                    
                                    Text("❌ Tua risposta: \(error.userAnswer)")
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
                    .listStyle(PlainListStyle()) // Per mantenere l'aspetto senza bordi
                    .padding(.horizontal, 16)
                }
                .navigationTitle("Mistakes")
                .onAppear {
                    errorManager.loadErrors()
                }
                
            }
        }
    }
    
}
    
    struct ErrorsView_Previews: PreviewProvider {
        static var previews: some View {
            ErrorsView()
                .environmentObject(ErrorManager()) // Provide an environment object for the preview
        }
    }

