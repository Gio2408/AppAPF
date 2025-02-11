import SwiftUI

struct QuizView: View {
    @EnvironmentObject var errorManager: ErrorManager
    
    @State private var score: Int = 0 // Conta gli errori all'inizio, poi calcolerà il punteggio finale
    @State private var selectedAnswer: String?
    @State private var errorMessage: String?
    @State private var currentPhaseIndex: Int = 0 // Traccia la fase corrente
    
    struct QuizTurn {
        let question: String
        let correctAnswer: String
        let imageName: String
    }
    
    let quizTurns = [
        QuizTurn(question: "If your car battery dies, you can jump-start the engine using cables connected to another car’s battery.", correctAnswer: "T", imageName: "image1"),
                
                QuizTurn(question: "You should only change the engine oil when the warning light on the dashboard turns on.", correctAnswer: "F", imageName: "image2"),
                
                QuizTurn(question: "Braking distance increases when driving on wet roads compared to dry conditions.", correctAnswer: "T", imageName: "image3"),
                
                QuizTurn(question: "At an intersection with no signs or traffic lights, the driver coming from the right has the right of way.", correctAnswer: "T", imageName: "image1"),
                
                QuizTurn(question: "Winter tires are mandatory across all regions of Italy from November 15 to April 15.", correctAnswer: "F", imageName: "image2"),
                
                QuizTurn(question: "You can use high beams in city areas to improve visibility.", correctAnswer: "F", imageName: "image3"),
                
                QuizTurn(question: "If your engine overheats, you should immediately open the radiator to release the steam.", correctAnswer: "F", imageName: "image1"),
                
                QuizTurn(question: "While driving, you must keep both hands on the steering wheel at all times, except when using essential controls like turn signals or the gear shift.", correctAnswer: "T", imageName: "image2"),
                
                QuizTurn(question: "Using the handbrake while driving at high speed can help you stop the car faster in an emergency.",
                         correctAnswer: "F", imageName: "image3"),
        
                QuizTurn(question: "If you have a tire blowout while driving, you should immediately brake as hard as possible to stop the car.", correctAnswer: "F", imageName: "image1")

    ]
    
    func checkAnswer(turn: QuizTurn) {
        if selectedAnswer != turn.correctAnswer {
            let error = QuizError(question: turn.question, correctAnswer: turn.correctAnswer, userAnswer: selectedAnswer ?? "Nessuna risposta")
            errorManager.addError(error)
            errorMessage = "Risposta errata! Riprova."
            score += 1 // Conta gli errori
        } else {
            errorMessage = "Risposta corretta! Passa alla fase successiva."
        }
        currentPhaseIndex += 1 // Avanza sempre alla prossima domanda
    }

    var body: some View {
        VStack {
            if currentPhaseIndex < quizTurns.count {
                let turn = quizTurns[currentPhaseIndex]

                Image(turn.imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                    .padding(.top, 20)

                Text(turn.question)
                    .font(.title)
                    .padding()

                HStack {
                    Button(action: {
                        selectedAnswer = "T"
                        checkAnswer(turn: turn)
                    }) {
                        Text(" T  ")
                            .font(.headline)
                            .padding()
                            .background(Color.green)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                    .padding()

                    Button(action: {
                        selectedAnswer = "F"
                        checkAnswer(turn: turn)
                    }) {
                        Text(" F  ")
                            .font(.headline)
                            .padding()
                            .background(Color.red)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                    .padding()
                }

                if let errorMessage = errorMessage {
                    Text(errorMessage)
                        .font(.subheadline)
                        .foregroundColor(errorMessage == "Risposta corretta! Passa alla fase successiva." ? .green : .red)
                        .padding()
                }
            } else {
                let finalScore = quizTurns.count - score // Calcolo punteggio finale
                Text("Hai completato il quiz! Punteggio: \(finalScore)/\(quizTurns.count)")
                    .font(.title)
                    .foregroundColor(.green)
                    .padding()
            }
        }
        .padding()
    }
}

struct QuizView_Previews: PreviewProvider {
    static var previews: some View {
        QuizView()
            .environmentObject(ErrorManager())
    }
}
