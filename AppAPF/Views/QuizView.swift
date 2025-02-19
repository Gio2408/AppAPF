import SwiftUI

struct QuizView: View {
    
    @Binding var isInQuizView: Bool
    @EnvironmentObject var errorManager: ErrorManager
    @EnvironmentObject var scoreManager: ScoreManager
    @Environment(\.presentationMode) var presentationMode // Enables dismissing the scene
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
    
    func checkAnswer(turn: QuizTurn) { // turn: a variable needed for the function, so it doesn’t give an error (turn = quizTurns)
        if scoreManager.currentQuestion == 0 { // If: reinitialize all variables for safety
            scoreManager.resetScore()
            errorManager.deleteErrors() // Removes all previous errors, so only the recently made ones will be shown
        }
        if selectedAnswer != turn.correctAnswer {
            // Add the error if the answer is wrong
            let error = QuizError(question: turn.question, correctAnswer: turn.correctAnswer, userAnswer: selectedAnswer ?? "N/A")
            errorManager.addError(error)
            errorMessage = "Wrong answer!"
            
        } else {
            errorMessage = "Correct answer!"
            scoreManager.incrementScore() // Tracks the count of correct answers
        }
        
        scoreManager.incrementQuestion() // Tracks the current question count for comparison later
        
        if scoreManager.currentQuestion == quizTurns.count { // compares the current question with the total number of questions
            scoreManager.score.totalAnswers = quizTurns.count // assigns the total number of questions to totalAnswers, to display in ScoreView
            scoreManager.saveAnswers() // saves the total number of questions
            if scoreManager.mTotalScore > scoreManager.score.totalScore { // if necessary: update the score of correct answers only if they are more than the previous ones
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
                    Image(quizTurns[scoreManager.currentQuestion].imageName) // accesses the current position in the array and takes the image for that position
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
                Button(action: { // this button is different
                    withAnimation(.easeInOut(duration: 0.5)) {
                        isInQuizView = false  // Return to ContentView with a fade animation
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
