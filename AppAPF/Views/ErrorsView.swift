import SwiftUI

struct ErrorsView: View {
    @EnvironmentObject var errorManager: ErrorManager
    
    var body: some View {
        NavigationView {
            ZStack {
                // Sfondo verde chiaro per un look più giocoso
                Color(red: 0.65, green: 0.80, blue: 0.45)
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    List {
                        ForEach(errorManager.errors) { error in
                            HStack(spacing: 20) {
                                Image(systemName: "exclamationmark.triangle.fill")
                                    .foregroundColor(.yellow)
                                    .font(.title)
                                
                                VStack(alignment: .leading, spacing: 5) {
                                    Text(error.question)
                                        .font(.system(size: 20, weight: .bold, design: .rounded))
                                        .foregroundColor(.black)
                                    
                                    Text("✅ Risposta corretta: \(error.correctAnswer)")
                                        .foregroundColor(.green)
                                        .font(.system(size: 18, design: .rounded))
                                    
                                    Text("❌ Tua risposta: \(error.userAnswer)")
                                        .foregroundColor(.red)
                                        .font(.system(size: 18, design: .rounded))
                                }
                            }
                            .padding()
                            .background(Color.white) // Rimuove lo sfondo del container
                            .shadow(color: .gray.opacity(0.3), radius: 4, x: 0, y: 2)
                            .frame(width: 585, height: 100)
                            .listRowBackground(Color.clear)
                            
                             
                        }
                        .onDelete { indices in
                            errorManager.errors.remove(atOffsets: indices)
                            errorManager.saveErrors()
                        }
                    }
                    .listStyle(PlainListStyle()) // Per mantenere l'aspetto senza bordi
                    .padding(.horizontal, 16)
                    .background(Color.clear) // Rende la List trasparente
                    .scrollContentBackground(.hidden) // Nasconde lo sfondo della lista su iOS 16+
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
            .environmentObject(ErrorManager())
    }
}
