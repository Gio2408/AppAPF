import SwiftUI

struct QuizView: View {
    
    @Binding var isInQuizView: Bool
    @EnvironmentObject var errorManager: ErrorManager
    @EnvironmentObject var scoreManager: ScoreManager
    @Environment(\.presentationMode) var presentationMode //per abiltare il dismiss della scene
    @State private var selectedAnswer: String?
    @State private var errorMessage: String?
    
    struct QuizTurn {
        let question: String
        let correctAnswer: String
        let imageName: String
    }
    
    // Quiz questions and answers
    let quizTurns = [
        QuizTurn(question: "At unsigned intersections, the driver on the right always has the right of way.", correctAnswer: "T", imageName: "quiz1"),
        QuizTurn(question: "Passing a vehicle stopped at a pedestrian crossing is always allowed.", correctAnswer: "F", imageName: "quiz2"),
        QuizTurn(question: "The driver can be fined if a passenger isn’t wearing a seatbelt.", correctAnswer: "T", imageName: "quiz3"),
        QuizTurn(question: "Braking distance decreases when it rains.", correctAnswer: "F", imageName: "quiz4"),
        QuizTurn(question: "After an accident, a motorcyclist's helmet should always be removed immediately.", correctAnswer: "F", imageName: "quiz5"),
        QuizTurn(question: "112 is the emergency number in Europe.", correctAnswer: "T", imageName: "quiz6"),
        QuizTurn(question: "Fog can make vehicles ahead look farther away. ", correctAnswer: "F", imageName: "quiz7"),
        QuizTurn(question: "Smooth driving helps reduce fuel consumption.", correctAnswer: "T", imageName: "quiz8"),
        QuizTurn(question: "After an accident, if a fire starts and there’s no extinguisher, you can use a wet blanket to put out the flames.", correctAnswer: "T", imageName: "quiz9"),
        QuizTurn(question: "A red traffic light allows you to turn right with caution, giving way to pedestrians.", correctAnswer: "F", imageName: "quiz10")
    ]
    
    func checkAnswer(turn: QuizTurn) { // turn: variabile che serve per la funzione, in modo che non dia errore (turn = quizTurns)
        if scoreManager.currentQuestion == 0 { // If: re-inizializzare tutte le variabili per sicurezza
            scoreManager.resetScore()
            errorManager.errors.removeAll() // Rimuove tutti gli errori precedenti, così da far vedere solo quelli appena commessi
        }
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
        
        if scoreManager.currentQuestion == quizTurns.count { // confronta la domanda corrente con il totale delle domande
            scoreManager.score.totalAnswers = quizTurns.count // assegna il valore delle domande totali a totalAnswers, per riportarlo nella ScoreView
            scoreManager.saveAnswers() // salva il numero totale delle domande
            if scoreManager.mTotalScore > scoreManager.score.totalScore { //if necessario: aggiorna lo score delle risposte giuste solo se sono di più di quelle precedenti
                scoreManager.saveScore()
            }
        }
    }


    var body: some View {
        ZStack (alignment: .topLeading) {
            Image("road2")
                .resizable()
                .scaledToFit()
                .edgesIgnoringSafeArea(.all)
                .blur(radius: 7)
            VStack {
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
                        .foregroundColor(.black)
                        .padding(.top, 20)
                        .padding(.horizontal, 30)


                    // Answer buttons
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

                    // Show error message (correct or incorrect answer)
                    if let errorMessage = errorMessage {
                        Text(errorMessage)
                            .font(.subheadline)
                            .foregroundColor(errorMessage == "Correct answer!" ? .green : .red)
                            .padding(.top, 20)
                    }
                } else {
                    Text("You completed the quiz! Score: \(scoreManager.mTotalScore)/\(quizTurns.count)")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.green)
                        .padding(.top, 30)
                    
                }
            }//VStack end
            .padding()
            .background(Color.white)
            .cornerRadius(10)
            .shadow(radius: 10)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            
            // Back button in the top-left corner using NavigationLink
                Button(action: { //questo  bottone è diverso
                    withAnimation(.easeInOut(duration: 0.5)) {
                        isInQuizView = false  // Torna a ContentView con animazione fade
                        print ("Back to HomeView")
                        presentationMode.wrappedValue.dismiss()
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
        
        
    }
}
struct QuizView_Previews: PreviewProvider {
    static var previews: some View {
        QuizView(isInQuizView: .constant(true))
            .environmentObject(ErrorManager())
            .environmentObject(ScoreManager())
    }
}
