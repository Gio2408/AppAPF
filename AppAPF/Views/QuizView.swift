import SwiftUI

struct QuizView: View {
    @Binding var isInQuizView: Bool
    @EnvironmentObject var errorManager: ErrorManager
    @EnvironmentObject var scoreManager: ScoreManager
    @EnvironmentObject var quizManager: QuizManager
    
    @State private var score: Int = 0
    @State private var selectedAnswer: String?
    @State private var errorMessage: String?
    
    struct QuizTurn {
        let question: String
        let correctAnswer: String
        let imageName: String
    }
    
    let quizTurns = [
        QuizTurn(question: "If your car battery dies, you can jump-start the engine using cables connected to another car’s battery.", correctAnswer: "T", imageName: "image1"),
        QuizTurn(question: "You should only change the engine oil when the warning light on the dashboard turns on.", correctAnswer: "F", imageName: "image2"),
        QuizTurn(question: "Braking distance increases when driving on wet roads compared to dry conditions.", correctAnswer: "T", imageName: "image3")
    ]
    
    func checkAnswer(turn: QuizTurn) {
        if selectedAnswer != turn.correctAnswer {
            let error = QuizError(question: turn.question, correctAnswer: turn.correctAnswer, userAnswer: selectedAnswer ?? "N/A")
            errorManager.addError(error)
            errorMessage = "Wrong answer!"
            score += 1
        } else {
            errorMessage = "Correct answer!"
        }
        quizManager.currentPhaseIndex += 1
        
        if quizManager.currentPhaseIndex == quizTurns.count {
            let finalScore = quizTurns.count - score
            scoreManager.score.totalScore = finalScore
        }
    }

    var body: some View {
        NavigationStack {
            VStack {
                // Back button in the top-left corner using NavigationLink
                HStack {
                    Button(action: {
                        withAnimation(.easeInOut(duration: 0.5)) {
                            isInQuizView = false  // Torna a ContentView con animazione fade
                        }
                    }) {
                        Image(systemName: "arrow.left.circle.fill")
                            .resizable()
                            .frame(width: 50, height: 50)
                            .foregroundColor(.white)
                            .background(Circle().fill(Color.black.opacity(0.5)))
                    }
                    .padding(.leading, 20)

                    Spacer()
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.top, 10)
                .padding(.leading, 10)

                if quizManager.currentPhaseIndex < quizTurns.count {
                    let turn = quizTurns[quizManager.currentPhaseIndex]

                    Image(turn.imageName)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 250, height: 250)
                        .padding(.top, 30)

                    Text(turn.question)
                        .font(.title)
                        .fontWeight(.medium)
                        .multilineTextAlignment(.center)
                        .padding(.top, 20)
                        .padding(.horizontal, 30)

                    HStack {
                        Button(action: {
                            selectedAnswer = "T"
                            checkAnswer(turn: turn)
                        }) {
                            Text("True")
                                .font(.headline)
                                .padding()
                                .frame(width: 120, height: 50)
                                .background(Color.green)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                                .shadow(radius: 5)
                        }
                        .padding()

                        Button(action: {
                            selectedAnswer = "F"
                            checkAnswer(turn: turn)
                        }) {
                            Text("False")
                                .font(.headline)
                                .padding()
                                .frame(width: 120, height: 50)
                                .background(Color.red)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                                .shadow(radius: 5)
                        }
                        .padding()
                    }

                    if let errorMessage = errorMessage {
                        Text(errorMessage)
                            .font(.subheadline)
                            .foregroundColor(errorMessage == "Correct answer!" ? .green : .red)
                            .padding(.top, 20)
                    }
                } else {
                    let finalScore = quizTurns.count - score
                    Text("You completed the quiz! Score: \(finalScore)/\(quizTurns.count)")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.green)
                        .padding(.top, 30)
                }
            }
            .padding()
            .background(Color.white)
            .cornerRadius(10)
            .shadow(radius: 10)
        }
    }
}
#Preview {
    QuizView(isInQuizView: .constant(true))
        .environmentObject(ScoreManager(score: QuizScore(quiz: "Quiz Incroci", totalScore: 8, totalAnswers: 10), currentScore: 0, quizManager: QuizManager()))
        .environmentObject(ErrorManager())
        .environmentObject(QuizManager())
}
