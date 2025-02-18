import SwiftUI

struct ErrorsView: View {
    @EnvironmentObject var errorManager: ErrorManager // Access to the errorManager object

    var body: some View {
        NavigationView {
            ZStack(alignment: .bottomTrailing) {
                Image("backv")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
                
                ScrollView {
                    VStack(alignment: .leading) {
                        Spacer().frame(height: 40)
                        
                        ForEach(errorManager.errors) { error in
                            VStack(alignment: .leading) {
                                Text(error.question)
                                    .font(.headline)
                                    .foregroundColor(.black)
                                Spacer()
                                Text("Risposta corretta: \(error.correctAnswer)")
                                    .foregroundColor(.green)
                                Spacer()
                                Text("Tua risposta: \(error.userAnswer)")
                                    .foregroundColor(.red)
                                Spacer()
                            }
                            .padding()
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .background(Color.white.opacity(0.9))
                            .cornerRadius(15)
                            .shadow(color: .black, radius: 3)
                            .padding(.horizontal, 23)
                            .padding(.vertical, 1)
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .onAppear {
                        errorManager.loadErrors()
                    }
                }
            }
            .navigationTitle("Mistakes")
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarTrailing) { // Posiziona gli elementi nella parte sinistra della barra di navigazione
                    Button(action: {
                        errorManager.errors.removeAll()
                        errorManager.saveErrors()
                    }) {
                        Text("delete all")
                            .foregroundColor(.red)
                            .font(.system(.body, design: .default))
                            .baselineOffset(90)
                    }
                }
            }
        }
    }
}
