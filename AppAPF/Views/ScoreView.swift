import SwiftUI

struct ScoreView: View {
    @EnvironmentObject var scoreManager: ScoreManager
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        NavigationView {
            ScrollView {
                VStack {

                    // Show current quiz score
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Quiz attuale: \(scoreManager.score.quiz)") // Current quiz title
                            .font(.title2)
                            .fontWeight(.semibold)

                        Text("Punteggio: \(scoreManager.score.totalScore)/\(scoreManager.score.totalAnswers)") // Current score
                            .font(.headline)
                            .foregroundColor(.green)
                            .padding(.bottom, 20)

                        // Progress bar showing the score as a fraction of total answers
                        ProgressView(value: Double(scoreManager.score.totalScore), total: Double(scoreManager.score.totalAnswers))
                            .progressViewStyle(LinearProgressViewStyle())
                            .padding(.bottom, 20)
                    }
                    .padding(.horizontal)
                    
                    // Show previous quiz scores
                    VStack {
                        Text("Punteggi precedenti") // Previous scores section title
                            .font(.title2)
                            .fontWeight(.semibold)
                            .padding(.top)

                        List(scoreManager.completedQuizzes, id: \.quiz) { completedQuiz in
                            HStack {
                                VStack(alignment: .leading) {
                                    Text(completedQuiz.quiz) // Quiz name
                                        .font(.headline)
                                    Text("Punteggio: \(completedQuiz.totalScore)/\(completedQuiz.totalAnswers)") // Previous quiz score
                                        .font(.subheadline)
                                        .foregroundColor(.gray)
                                }
                                Spacer()
                                Text("\(completedQuiz.totalScore)") // Displaying the score in green
                                    .font(.headline)
                                    .foregroundColor(.green)
                            }
                            .padding(.vertical, 5)
                        }
                    }
                    .padding(.horizontal)
                    
                    /* A cosa serviva questo??? Due pulsanti per fare la stessa cosa? Perche?
                     
                     ( Button to go back to the main content view
                    Button(action: {
                        withAnimation(.easeInOut(duration: 0.5)) {
                            presentationMode.wrappedValue.dismiss() // Dismiss the current view with animation
                        }
                    }) {
                        Text("Go Back")
                            .font(.title2)
                            .foregroundColor(.blue)
                    }
                    .padding(.top, 20)*/
                }
            }
            .navigationTitle("Quiz Score")
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
