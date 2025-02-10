import SwiftUI

struct QuizView: View {
    @EnvironmentObject var errorManager: ErrorManager
    
    @State private var selectedAnswer: String?
    @State private var errorMessage: String?
    @State private var currentPhaseIndex: Int = 0 // Traccia la fase corrente
    
    struct QuizTurn {
        let question: String
        let correctAnswer: String
        let imageName: String
    }
    
    let quizTurns = [
        QuizTurn(question: "Fase 1", correctAnswer: "Go", imageName: "image1"),
        QuizTurn(question: "Fase 2", correctAnswer: "Wait", imageName: "image2"),
        QuizTurn(question: "Fase 3", correctAnswer: "Go", imageName: "image3")
    ]
    
    // Funzione per verificare la risposta
    func checkAnswer(turn: QuizTurn) {
        if selectedAnswer != turn.correctAnswer {
            // Se la risposta è errata, salva l'errore
            let error = QuizError(question: turn.question, correctAnswer: turn.correctAnswer, userAnswer: selectedAnswer ?? "Nessuna risposta")
            errorManager.addError(error)
            
            // Imposta il messaggio di errore e non cambia la fase
            errorMessage = "Risposta errata! Riprova."
        } else {
            // Risposta corretta, passa alla fase successiva
            errorMessage = "Risposta corretta! Passa alla fase successiva."
            currentPhaseIndex += 1
        }
    }

    var body: some View {
        
        VStack {
            // Mostra la fase solo se la fase corrente è valida
            if currentPhaseIndex < quizTurns.count {
                let turn = quizTurns[currentPhaseIndex]
                
                // Mostra l'immagine
                Image("road")  // Sostituisci con il nome dell'immagine dalla fase, da sostituire poi con turn.imageName quando le avremo in Assets
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                    .padding(.top, 20)
                
                // La domanda
                Text(turn.question)
                    .font(.title)
                    .padding()

                // I bottoni per le risposte
                HStack {
                    Button(action: {
                        selectedAnswer = "Go"
                        checkAnswer(turn: turn)
                    }) {
                        Text("Go")
                            .font(.headline)
                            .padding()
                            .background(Color.green)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                    .padding()

                    Button(action: {
                        selectedAnswer = "Wait"
                        checkAnswer(turn: turn)
                    }) {
                        Text("Wait")
                            .font(.headline)
                            .padding()
                            .background(Color.red)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                    .padding()
                }

                // Mostra il messaggio di errore o successo
                if let errorMessage = errorMessage {
                    Text(errorMessage)
                        .font(.subheadline)
                        .foregroundColor(errorMessage == "Risposta corretta!" ? .green : .red)
                        .padding()
                }
            } else {
                // Messaggio finale: il quiz è completato
                Text("Hai completato il quiz!")
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
