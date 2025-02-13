import SwiftUI

struct ScoreView: View {
    @EnvironmentObject var scoreManager: ScoreManager
    @Binding var isInScoreView: Bool // Binding per tornare alla schermata precedente
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        VStack {
            HStack {
                Button(action: {
                    withAnimation {
                        isInScoreView = false // Torna alla schermata precedente
                    }
                }) {
                    Image(systemName: "arrow.backward")
                        .font(.title)
                        .foregroundColor(.blue)
                }
                Spacer()
            }
            .padding()

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

                List(scoreManager.completedQuizzes, id: \.quiz) { completedQuiz in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(completedQuiz.quiz) // Non serve `String()`
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

#Preview {
    struct PreviewWrapper: View {
        @State private var isInScoreView = true
        let quizManager = QuizManager()
        let score = QuizScore(quiz: "Quiz Incroci", totalScore: 8, totalAnswers: 10)
        let scoreManager: ScoreManager

        init() {
            scoreManager = ScoreManager(score: score, currentScore: 8, quizManager: quizManager)
            scoreManager.completedQuizzes = [
                QuizScore(quiz: "Quiz Patente", totalScore: 8, totalAnswers: 10),
                QuizScore(quiz: "Quiz Sicurezza", totalScore: 7, totalAnswers: 10)
            ]
        }

        var body: some View {
            ScoreView(isInScoreView: $isInScoreView)
                .environmentObject(scoreManager)
        }
    }

    return PreviewWrapper()
}
