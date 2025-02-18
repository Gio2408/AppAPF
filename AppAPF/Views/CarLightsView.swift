
import SwiftUI

struct CarLightsView: View {
    @Binding var isInCarLightsView: Bool
    @Environment(\.presentationMode) var presentationMode
    
    @EnvironmentObject var errorManager: ErrorManager
    @EnvironmentObject var scoreManager: ScoreManager
    @State private var selectedAnswer: String?
    @State private var errorMessage: String?
    
    struct Date {
        let question: String
        let correctAnswer: String
        let imageName: String
    }
    
    let dates = [
        Date(question: "If you see a red warning light, what should you do first?", correctAnswer: "C", imageName: "image1"),
        Date(question: " Which of these warning lights indicates a problem that could cause immediate damage to the engine?", correctAnswer: "A", imageName: "image2"),
        Date(question: " Which color of warning lights generally indicates an urgent problem that requires immediate attention?", correctAnswer: "D", imageName: "image3"),
        Date(question: "If the engine temperature light turns red, what should you NOT do?", correctAnswer: "A", imageName: "image3"),
    ]
    
    func checkAnswer(turn: Date) { // turn: variabile che serve per la funzione, in modo che non dia errore (turn = quizTurns)
        if selectedAnswer != turn.correctAnswer {
            // Add the error if the answer is wrong
            let error = QuizError(question: turn.question, correctAnswer: turn.correctAnswer, userAnswer: selectedAnswer ?? "N/A")
            errorManager.addError(error)
            errorMessage = "Wrong answer!"
            
        } else {
            errorMessage = "Correct answer!"
            scoreManager.incrementScore() // tiene il conteggio del numero delle risposte corrette
        }
        
        scoreManager.incrementQuestion() // tiene il conteggio della domanda corrente, per confrontarla dopo
        
        if scoreManager.currentQuestion == dates.count { // confronta la domanda corrente con il totale delle domande
            scoreManager.score.totalAnswers = dates.count // assegna il valore delle domande totali a totalAnswers, per riportarlo nella ScoreView
            scoreManager.saveAnswers() // salva il numero totale delle domande
            if scoreManager.mTotalScore > scoreManager.score.totalScore { //if necessario: aggiorna lo score delle risposte giuste solo se sono di più di quelle precedenti
                scoreManager.saveScore()
            }
        }
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                // Back button
                HStack {
                    Button(action: {
                        withAnimation(.easeInOut(duration: 0.5)) {
                            isInCarLightsView = false
                            presentationMode.wrappedValue.dismiss()
                        }
                    }) {
                        Image(systemName: "arrow.left.circle.fill")
                            .resizable()
                            .frame(width: 50, height: 50)
                            .foregroundColor(.white)
                            .background(Circle().fill(Color.blue.opacity(0.7)))
                    }
                    .padding(.leading, 20)
                    Spacer()
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.top, 10)
                
                if scoreManager.currentQuestion < dates.count {
                    let turn = dates[scoreManager.currentQuestion]
                    
                    // Display image
                    Image(turn.imageName)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 300, height: 200)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        .shadow(radius: 10)
                        .padding(.top, 30)
                    
                    // Display question
                    Text(turn.question)
                        .font(.title2)
                        .fontWeight(.bold)
                        .multilineTextAlignment(.center)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.purple.opacity(0.7))
                        .cornerRadius(15)
                        .padding(.horizontal, 20)
                    
                    // Display answer buttons
                    VStack(spacing: 20) {
                        ForEach(["A", "B", "C", "D"], id: \ .self) { answer in
                            Button(action: {
                                selectedAnswer = answer
                                checkAnswer(turn: turn)
                            }) {
                                HStack {
                                    Text("\(answer):")
                                        .font(.headline)
                                        .frame(width: 40)
                                    Text("Answer \(answer) description") // Placeholder for answer descriptions
                                        .font(.body)
                                }
                                .foregroundColor(.white)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(answer == "A" || answer == "C" ? Color.green : Color.red)
                                .cornerRadius(15)
                                .shadow(radius: 5)
                            }
                        }
                    }
                    .padding(.horizontal, 20)
                    
                    // Show feedback
                    if let errorMessage = errorMessage {
                        Text(errorMessage)
                            .font(.subheadline)
                            .foregroundColor(errorMessage == "Correct answer!" ? .green : .red)
                            .padding(.top, 20)
                    }
                    
                } else {
                    Text("You completed the quiz! Score: \(scoreManager.mTotalScore)/\(dates.count)")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.green)
                        .padding(.top, 30)
                }
            }
            .padding()
            .background(LinearGradient(gradient: Gradient(colors: [Color.blue.opacity(0.3), Color.purple.opacity(0.3)]), startPoint: .top, endPoint: .bottom))
            .cornerRadius(20)
            .shadow(radius: 15)
        }
    }
    struct CarLightsView_Previews: PreviewProvider {
        static var previews: some View {
            CarLightsView(isInCarLightsView: .constant(true))
                .environmentObject(ErrorManager())
                .environmentObject(ScoreManager())
        }
    }
}
