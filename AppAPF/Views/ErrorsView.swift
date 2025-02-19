import SwiftUI

struct ErrorsView: View {
    @EnvironmentObject var errorManager: ErrorManager
    
    var body: some View {
        NavigationView {
            ZStack {
                Color(red: 0.65, green: 0.80, blue: 0.45)
                    .edgesIgnoringSafeArea(.all)
                
                ScrollView {
                    VStack(spacing: 20) { // Spazio tra le sezioni
                        
                        // 🔹 Sezione Quiz Time
                        sectionHeader(title: "Quiz Time", imageName: "quizButton", count: errorManager.errors.count)
                        
                        // 🔹 Lista Errori Quiz Time
                        List {
                            ForEach(errorManager.errors) { error in
                                errorRow(error: error)
                            }
                            .onDelete { indices in
                                errorManager.errors.remove(atOffsets: indices)
                                errorManager.saveErrors()
                            }
                            .listRowBackground(Color.clear)
                        }
                        .listStyle(PlainListStyle())
                        .frame(height: CGFloat(errorManager.errors.count) * 120) // Adatta l'altezza alla lista
                        .scrollContentBackground(.hidden) // Nasconde lo sfondo della lista su iOS 16+
                        
                        // 🔹 Sezione Warning Lights
                        sectionHeader(title: "Warning Lights", imageName: "carLights", count: errorManager.errors.count)
                        
                        // 🔹 Lista Errori Warning Lights
                        List {
                            ForEach(errorManager.errors) { error in
                                errorRow(error: error)
                            }
                            .onDelete { indices in
                                errorManager.errors.remove(atOffsets: indices)
                                errorManager.saveErrors()
                            }
                            .listRowBackground(Color.clear)
                        }
                        .listStyle(PlainListStyle())
                        .frame(height: CGFloat(errorManager.errors.count) * 120) // Adatta l'altezza alla lista
                        .scrollContentBackground(.hidden) // Nasconde lo sfondo della lista su iOS 16+

                    }
                    .padding(.vertical, 20) // Spazio tra i blocchi
                }
                .navigationTitle("Mistakes")
                .onAppear {
                    errorManager.loadErrors()
                }
            }
        }
    }
    
    // 🔹 Componente per la sezione intestazione (titolo + immagine + conteggio errori)
    private func sectionHeader(title: String, imageName: String, count: Int) -> some View {
        VStack {
            HStack {
                Image(imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50, height: 50)
                
                Text(title)
                    .font(.title)
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity, alignment: .trailing)
            }
            .padding()
            
            Text("Number of mistakes: \(count)")
                .padding(.horizontal, 15)
                .padding(.vertical, 5)
                .frame(maxWidth: .infinity, alignment: .center)
                .foregroundColor(.white)
                .background(Color.red)
                .cornerRadius(15)
                .fontWeight(.semibold)
                .font(.title2)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.white.opacity(0.9))
        .cornerRadius(15)
        .shadow(color: .black.opacity(0.2), radius: 4)
        .padding(.horizontal, 23)
    }
    
    // 🔹 Componente per ogni riga di errore
    private func errorRow(error: QuizError) -> some View {
        HStack(spacing: 20) {
            Image(systemName: "exclamationmark.triangle.fill")
                .foregroundColor(.yellow)
                .font(.title)
            
            VStack(alignment: .leading, spacing: 5) {
                Text(error.question)
                    .font(.system(size: 20, weight: .bold, design: .rounded))
                    .foregroundColor(.black)
                    .lineLimit(nil)
                    .fixedSize(horizontal: false, vertical: true)
                
                Text("✅ Risposta corretta: \(error.correctAnswer)")
                    .foregroundColor(.green)
                    .font(.system(size: 18, design: .rounded))
                
                Text("❌ Tua risposta: \(error.userAnswer)")
                    .foregroundColor(.red)
                    .font(.system(size: 18, design: .rounded))
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(20)
        .shadow(color: .gray.opacity(0.3), radius: 4)
        .padding(.horizontal, 16)
    }
}

struct ErrorsView_Previews: PreviewProvider {
    static var previews: some View {
        ErrorsView()
            .environmentObject(ErrorManager())
    }
}
