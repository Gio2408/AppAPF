//Il tutto è da tradurre in inglese
import SwiftUI

struct QuizView: View {
    @EnvironmentObject var errorManager: ErrorManager
    @EnvironmentObject var scoreManager: ScoreManager
    @EnvironmentObject var quizManager: QuizManager
    
    @State private var score: Int = 0 // Conta gli errori all'inizio, poi calcolerà il punteggio finale
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
        QuizTurn(question: "Braking distance increases when driving on wet roads compared to dry conditions.", correctAnswer: "T", imageName: "image3"),
        QuizTurn(question: "At an intersection with no signs or traffic lights, the driver coming from the right has the right of way.", correctAnswer: "T", imageName: "image1"),
        QuizTurn(question: "Winter tires are mandatory across all regions of Italy from November 15 to April 15.", correctAnswer: "F", imageName: "image2"),
        QuizTurn(question: "You can use high beams in city areas to improve visibility.", correctAnswer: "F", imageName: "image3"),
        QuizTurn(question: "If your engine overheats, you should immediately open the radiator to release the steam.", correctAnswer: "F", imageName: "image1"),
        QuizTurn(question: "While driving, you must keep both hands on the steering wheel at all times, except when using essential controls like turn signals or the gear shift.", correctAnswer: "T", imageName: "image2"),
        QuizTurn(question: "Using the handbrake while driving at high speed can help you stop the car faster in an emergency.", correctAnswer: "F", imageName: "image3"),
        QuizTurn(question: "If you have a tire blowout while driving, you should immediately brake as hard as possible to stop the car.", correctAnswer: "F", imageName: "image1")
    ]
    
    func checkAnswer(turn: QuizTurn) {
        if selectedAnswer != turn.correctAnswer {
            let error = QuizError(question: turn.question, correctAnswer: turn.correctAnswer, userAnswer: selectedAnswer ?? "Nessuna risposta")
            errorManager.addError(error)
            errorMessage = "Risposta errata! "
            score += 1 // Conta gli errori
        } else {
            errorMessage = "Risposta corretta! "
        }
        quizManager.currentPhaseIndex += 1
        
        // Verifica se tutte le domande sono state fatte
        if quizManager.currentPhaseIndex == quizTurns.count {
            // Calcola il punteggio finale quando il quiz è completo
            let finalScore = quizTurns.count - score // Risposte corrette
            scoreManager.score.totalScore = finalScore // Aggiorna il punteggio finale
        }
    }

    var body: some View {
        VStack {
            // Visualizza l'immagine sopra la domanda
            if quizManager.currentPhaseIndex < quizTurns.count {
                let turn = quizTurns[quizManager.currentPhaseIndex]
                
                Image(turn.imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 250, height: 250)
                    .padding(.top, 30)
                
                // Visualizza la domanda al centro
                Text(turn.question)
                    .font(.title)
                    .fontWeight(.medium)
                    .multilineTextAlignment(.center)
                    .padding(.top, 20)
                    .padding(.horizontal, 30)
                
                // Pulsanti sotto la domanda
                HStack {
                    Button(action: {
                        selectedAnswer = "T"
                        checkAnswer(turn: turn)
                    }) {
                        Text("Vero")
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
                        Text("Falso")
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
                
                // Mostra il messaggio di errore o successo
                if let errorMessage = errorMessage {
                    Text(errorMessage)
                        .font(.subheadline)
                        .foregroundColor(errorMessage == "Risposta corretta! " ? .green : .red)
                        .padding(.top, 20)
                }
            } else {
                // Visualizza il punteggio finale quando il quiz è finito
                let finalScore = quizTurns.count - score // Calcolo punteggio finale
                Text("Hai completato il quiz! Punteggio: \(finalScore)/\(quizTurns.count)")
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

#Preview {
    // Crea l'istanza di QuizManager
    let quizManager = QuizManager()
    quizManager.currentPhaseIndex = 0 // Impostiamo la fase iniziale

    // Crea l'istanza di QuizScore
    let score = QuizScore(quiz: "Quiz Incroci", totalScore: 0)

    // Passa QuizManager all'inizializzatore di ScoreManager
    return QuizView()
        .environmentObject(ScoreManager(score: score, currentScore: 0, quizManager: quizManager))
        .environmentObject(quizManager) // Aggiungi QuizManager all'ambiente
        .environmentObject(ErrorManager()) // Se ErrorManager è necessario
}
