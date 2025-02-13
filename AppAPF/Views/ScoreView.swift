import SwiftUI

struct ScoreView: View {
    @EnvironmentObject var scoreManager: ScoreManager
    @Environment(\.presentationMode) var presentationMode

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
                    
                    // Bottone per tornare a ContentView
                    Button(action: {
                        withAnimation(.easeInOut(duration: 0.5)) {
                            presentationMode.wrappedValue.dismiss()
                        }
                    }) {
                        HStack {
                            Image(systemName: "arrow.left.circle.fill")
                                .font(.title)
                            Text("Torna Indietro")
                                .font(.headline)
                        }
                        .padding()
                        .foregroundColor(.blue)
                    }
                    .padding(.top, 20)
                }
            }
            .navigationTitle("Score")
            .gesture(
                DragGesture().onEnded { gesture in
                    if gesture.translation.width > 100 {
                        withAnimation(.easeInOut(duration: 0.5)) {
                            presentationMode.wrappedValue.dismiss()
                        }
                    }
                }
            )
        }
    }
}

#Preview {
    let quizManager = QuizManager()
    let score = QuizScore(quiz: "Quiz Incroci", totalScore: 8, totalAnswers: 10)
    let scoreManager = ScoreManager(score: score, currentScore: 8, quizManager: quizManager)

    scoreManager.completedQuizzes = [
        QuizScore(quiz: "Quiz Patente", totalScore: 8, totalAnswers: 10),
        QuizScore(quiz: "Quiz Sicurezza", totalScore: 7, totalAnswers: 10)
    ]

    return ScoreView()
        .environmentObject(scoreManager)
}
