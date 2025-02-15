import SwiftUI

struct ScoreView: View {
    @EnvironmentObject var scoreManager: ScoreManager
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        NavigationView {
                ScrollView {
                    VStack {
                                Text("Punteggio Totale Salvato:")
                                    .font(.title)
                        Text("\(scoreManager.score.totalScore)") // Mostra il punteggio da ScoreManager
                                    .font(.largeTitle)
                                    .fontWeight(.bold)
                            }
                            .onAppear {
                                scoreManager.loadScore() // **AGGIUNGI QUI: Carica il punteggio quando la vista appare**
                                print("ScoreView is appeared, loaded score again just to be sure: \(scoreManager.score.totalScore)") // Debug
                            }
                        /*VStack {
                                    // Titolo della schermata
                                    Text("Punteggi dei Quiz")
                                        .font(.largeTitle)
                                        .fontWeight(.bold)
                                        .padding()
                                Text("\nScoreManager \(ObjectIdentifier(scoreManager))") // AGGIUNGI QUESTO PRINT
                                                        Text("\n\(scoreManager.score.totalScore) \(scoreManager.score.totalAnswers == 1 ? "risposta" : "risposte")")

                                
                            }*/
                            .padding(.horizontal)
                    }
                    .navigationTitle("Score")
        }
    }
}

/*struct ScoreView_Previews: PreviewProvider {
    static var previews: some View {
        ScoreView()
            .environmentObject(ScoreManager()) // Fornisci l'environment object!
    }
}*/


/* COPIA BODY
 var body: some View {
     NavigationView {
         ScrollView {
             VStack {
                 // Titolo della schermata
                 Text("Punteggi dei Quiz")
                     .font(.largeTitle)
                     .fontWeight(.bold)
                     .padding()

                 // Mostra il punteggio attuale
                 VStack(alignment: .leading, spacing: 10) {
                     Text("Quiz attuale: \(scoreManager.score.quiz)")
                         .font(.title2)
                         .fontWeight(.semibold)
                     
                     Text("Punteggio: \(scoreManager.score.totalScore)/\(scoreManager.score.totalAnswers)")
                         .font(.headline)
                         .foregroundColor(.green)
                         .padding(.bottom, 20)
                     
                     // Barra di progresso
                     ProgressView(value: Double(scoreManager.score.totalScore), total: Double(scoreManager.score.totalAnswers))
                         .progressViewStyle(LinearProgressViewStyle())
                         .padding(.bottom, 20)
                 }
                 .padding(.horizontal)
                 
                 // Lista dei punteggi passati
                 VStack {
                     Text("Punteggi precedenti")
                         .font(.title2)
                         .fontWeight(.semibold)
                         .padding(.top)

                     // Visualizza la lista dei quiz completati
                     List(scoreManager.completedQuizzes, id: \.quiz) { completedQuiz in
                         HStack {
                             VStack(alignment: .leading) {
                                 Text(String(completedQuiz.quiz)) // Forza la conversione a String
                                     .font(.headline)
                                 Text("Punteggio: \(completedQuiz.totalScore)/\(completedQuiz.totalAnswers)")
                                     .font(.subheadline)
                                     .foregroundColor(.gray)
                             }
                             Spacer()
                             Text("\(completedQuiz.totalScore)")
                                 .font(.headline)
                                 .foregroundColor(.green)
                         }
                         .padding(.vertical, 5)
                     }

                 }
                 .padding(.horizontal)
             }
         }
         .navigationTitle("Score")
     }
 }
 */
