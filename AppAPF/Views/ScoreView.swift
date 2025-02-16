import SwiftUI

struct ScoreView: View {
    @EnvironmentObject var scoreManager: ScoreManager
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        ZStack { // Inizia ZStack per lo sfondo
            Image("road2") // Immagine di sfondo
                .resizable() // Rendi l'immagine ridimensionabile
                .scaledToFill() // Scala l'immagine per riempire lo spazio
                .opacity(0.8) // Opacità dello sfondo (opzionale, se vuoi renderlo semi-trasparente)
                .ignoresSafeArea() // Assicura che lo sfondo si estenda sotto la safe area
            
            NavigationView {
                ScrollView {
                    VStack {
                        /// QUIZ UNO - DA AGGIORNARE
                        VStack(alignment: .leading, spacing: 10) {
                            Text("Quiz uno: \(scoreManager.score.quiz)")
                                .font(.title2)
                                .fontWeight(.semibold)
                            
                            //HStack per allineare il punteggio al tasto elimina
                            HStack {
                                Text("Punteggio: \(scoreManager.score.totalScore)/\(scoreManager.score.totalAnswers)")
                                    .font(.headline)
                                    .foregroundColor(.green)
                                Spacer()
                                
                                Button(action: {scoreManager.score.totalScore = 0
                                    scoreManager.saveScore()
                                }) {
                                    Image(systemName: "trash")
                                        .padding(.horizontal)
                                        .foregroundColor(.black)
                                    
                                }
                            } .padding(.bottom, 20)
                            
                            // Barra di progresso QUIZ UNO
                            ProgressView(value: Double(scoreManager.score.totalScore), total: Double(scoreManager.score.totalAnswers))
                                .progressViewStyle(LinearProgressViewStyle())
                                .padding(.bottom, 40)
                        }
                        .padding(.horizontal)
                        
                        
                        /// QUIZ DUE - DA AGGIORNARE
                        VStack(alignment: .leading, spacing: 10) {
                            Text("Quiz due: \(scoreManager.score.quiz)")
                                .font(.title2)
                                .fontWeight(.semibold)
                            
                            //HStack per allineare il punteggio al tasto elimina
                            HStack {
                                Text("Punteggio: \(scoreManager.score.totalScore)/\(scoreManager.score.totalAnswers)")
                                    .font(.headline)
                                    .foregroundColor(.green)
                                Spacer()
                                
                                Button(action: {scoreManager.score.totalScore = 0
                                    scoreManager.saveScore()
                                }) {
                                    Image(systemName: "trash")
                                        .padding(.horizontal)
                                        .foregroundColor(.black)
                                }
                            } .padding(.bottom, 20)
                            
                            // Barra di progresso quiz DUE
                            ProgressView(value: Double(scoreManager.score.totalScore), total: Double(scoreManager.score.totalAnswers))
                                .progressViewStyle(LinearProgressViewStyle())
                                .padding(.bottom, 40)
                        }
                        .padding(.horizontal)
                        
                        
                        /// QUIZ TRE - DA AGGIORNARE
                        VStack(alignment: .leading, spacing: 10) {
                            Text("Quiz tre: \(scoreManager.score.quiz)")
                                .font(.title2)
                                .fontWeight(.semibold)
                            
                            //HStack per allineare il punteggio al tasto elimina
                            HStack {
                                Text("Punteggio: \(scoreManager.score.totalScore)/\(scoreManager.score.totalAnswers)")
                                    .font(.headline)
                                    .foregroundColor(.green)
                                Spacer()
                                
                                Button(action: {scoreManager.score.totalScore = 0
                                    scoreManager.saveScore()
                                }) {
                                    Image(systemName: "trash")
                                        .padding(.horizontal)
                                        .foregroundColor(.black)
                                }
                            } .padding(.bottom, 20)
                            
                            // Barra di progresso QUIZ TRE
                            ProgressView(value: Double(scoreManager.score.totalScore), total: Double(scoreManager.score.totalAnswers))
                                .progressViewStyle(LinearProgressViewStyle())
                                .padding(.bottom, 20)
                        }
                        .padding(.horizontal)
                    }
                    .onAppear {
                        scoreManager.loadScore()
                        scoreManager.loadAnswers()
                    }
                    .padding(.horizontal)
                }
                .navigationTitle("Score")
            }
            .background(Color.clear)
        }
    }
}

struct ScoreView_Previews: PreviewProvider {
    static var previews: some View {
        ScoreView()
            .environmentObject(ScoreManager()) // Fornisci l'environment object!
    }
}


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
