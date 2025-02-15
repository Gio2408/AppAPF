import SwiftUI

struct QuizView: View {
    @Binding var isInQuizView: Bool
    @EnvironmentObject var errorManager: ErrorManager
    @EnvironmentObject var scoreManager: ScoreManager
    

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
    
    func checkAnswer(turn: QuizTurn) { // turn: variabile che serve per la funzione, in modo che non dia errore (turn = quizTurns)
        if selectedAnswer != turn.correctAnswer {
            let error = QuizError(question: turn.question, correctAnswer: turn.correctAnswer, userAnswer: selectedAnswer ?? "N/A")
            errorManager.addError(error)
            errorMessage = "Wrong answer!"
            
        } else {
            errorMessage = "Correct answer!"
            scoreManager.addTotalScore() // tiene il conteggio del numero delle risposte corrette
        }
        
        scoreManager.addCurrentQuestion() // tiene il conteggio della domanda corrente, per confrontarla dopo
        
        if scoreManager.currentQuestion == quizTurns.count { // confronta la domanda corrente con il totale delle domande
            scoreManager.score.totalAnswers = quizTurns.count // assegna il valore delle domande totali a totalAnswers, per riportarlo nella ScoreView
        }
    }

    var body: some View {
        NavigationStack {
            VStack {
                Text("QuizView")
                Text("ScoreManager ObjectIdentifier: \(ObjectIdentifier(scoreManager))")
                // Back button in the top-left corner using NavigationLink
                HStack {
                    NavigationLink(destination: ContentView().navigationBarBackButtonHidden(true)) {
                        HStack {
                            Image(systemName: "arrow.left")
                                .font(.title)
                            Text("Back")
                                .font(.headline)
                        }
                        .padding()
                        .foregroundColor(.blue)
                    }
                    Spacer()
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.top, 10)
                .padding(.leading, 10)

                if  scoreManager.currentQuestion < quizTurns.count {
                    let turn = quizTurns[scoreManager.currentQuestion]
                    Image(quizTurns[scoreManager.currentQuestion].imageName) // entra nell'array in posizione attuale rispetto la domanda e di questa posizione prende l'immagine
                        .resizable()
                        .scaledToFit()
                        .frame(width: 250, height: 250)
                        .padding(.top, 30)

                    Text(quizTurns[scoreManager.currentQuestion].question)
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
                    Text("You completed the quiz! Score: \(scoreManager.score.totalScore)/\(quizTurns.count)")
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
/*#Preview {
}*/
