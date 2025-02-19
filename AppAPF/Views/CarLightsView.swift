import SwiftUI

struct CarLightsView: View {
    @Binding var isInCarLightsView: Bool
    @Environment(\.presentationMode) var presentationMode
    
    @EnvironmentObject var errorManager: ErrorManager
    @EnvironmentObject var scoreManager: ScoreManager
    @State private var selectedAnswer: String?
    @State private var errorMessage: String?
    @State private var showExitConfirmation: Bool = false
    
    struct Data {
        let question: String
        let correctAnswer: String
        let imageName: String
        let answers: [String: String]
    }
    
    let dates = [
        Data(
            question: "If you see a red warning light, what should you do first?",
            correctAnswer: "Check the car manual",
            imageName: "carLights1",
            answers: [
                "A": "Ignore it and hope it goes out by itself",
                "Check the car manual": "Check the car manual",
                "C": "Stop in a safe place and check the problem",
                "D": "Turn on the radio to avoid hearing about it"
            ]
        ),
        Data(
            question: "If the ABS (Anti-lock Braking System) warning light comes on, what should the driver do?",
            correctAnswer: "Check if the braking system is working correctly, but there might be a malfunction",
            imageName: "carLights2",
            answers: [
                "A": "Continue driving without worry",
                "B": "Stop immediately and call a tow truck",
                "Check if the braking system is working correctly, but there might be a malfunction": "Check if the braking system is working correctly, but there might be a malfunction",
                "D": "Change the brake pads"
            ]
        ),
        Data(
            question: "Which color of warning lights generally indicates an urgent problem that requires immediate attention?",
            correctAnswer: "Red",
            imageName: "carLights3",
            answers: [
                "A": "Green",
                "B": "Blue",
                "C": "Yellow",
                "Red": "Red"
            ]
        ),
        Data(
            question: "If the engine temperature light turns red, what should you NOT do?",
            correctAnswer: "Stop in a safe place and let the engine cool down",
            imageName: "carLights4",
            answers: [
                "A": "Continue driving as if nothing is wrong",
                "Stop in a safe place and let the engine cool down": "Stop in a safe place and let the engine cool down",
                "C": "Check the coolant level",
                "D": "Call a mechanic if the problem persists"
            ]
        ),
        Data(
            question: "If the low beam headlights light is on, what color is it?",
            correctAnswer: "Green",
            imageName: "carLights5",
            answers: [
                "A": "Blue",
                "Green": "Green",
                "C": "Yellow",
                "D": "Red"
            ]
        ),
        Data(
            question: "Which of these warning lights indicates a malfunction with the brake lights?",
            correctAnswer: "A yellow light with a light bulb and an exclamation point",
            imageName: "carLights6",
            answers: [
                "A": "A red light with an exclamation point inside a circle",
                "A yellow light with a light bulb and an exclamation poin": "A yellow light with a light bulb and an exclamation point",
                "C": "A blue light with a light bulb",
                "D": "None, the car does not warn about this issue"
            ]
        ),
        Data(
            question: "If the handbrake is engaged and you start driving, which warning light stays on?",
            correctAnswer: "A red light with a 'P' inside a circle",
            imageName: "carLights7",
            answers: [
                "A red light with a 'P' inside a circle": "A red light with a 'P' inside a circle",
                "B": "A yellow light with an exclamation point",
                "C": "A green light with a brake symbol",
                "D": "No light, the handbrake automatically disengages"
            ]
        ),
        Data(
            question: "If a red light with a circle and an exclamation point appears, what does it indicate?",
            correctAnswer: "A problem with the brakes or brake fluid",
            imageName: "carLights8",
            answers: [
                "A problem with the brakes or brake fluid": "A problem with the brakes or brake fluid",
                "B": "The fuel tank is almost empty",
                "C": "The ABS is deactivated",
                "D": "The windshield wipers are malfunctioning"
            ]
        ),
        Data(
            question: "If the seatbelt light is on, what does it mean?",
            correctAnswer: "Someone in the car hasn’t fastened their seatbelt",
            imageName: "carLights9",
            answers: [
                "A": "The car won’t start until the seatbelt is fastened",
                "Someone in the car hasn’t fastened their seatbelt": "Someone in the car hasn’t fastened their seatbelt",
                "C": "The safety system is deactivated",
                "D": "The driver's door is open"
            ]
        ),
        Data(
            question: "What color is this light generally?",
            correctAnswer: "Red",
            imageName: "carLights10",
            answers: [
                "A": "Yellow",
                "B": "Blue",
                "C": "Green",
                "Red": "Red"
            ]
        )
    ]

    func checkAnswer(turn: Data) {
        if selectedAnswer != turn.correctAnswer {
            // Add the error if the answer is wrong
            let errorLights = QuizError(question: turn.question, correctAnswer: turn.correctAnswer, userAnswer: selectedAnswer ?? "N/A")
            errorManager.addError(errorLights)
            errorMessage = "Wrong answer!"
        } else {
            errorMessage = "Correct answer!"
            scoreManager.incrementScore() // Keep track of the correct answers
        }
        
        scoreManager.incrementQuestion() // Increment the current question count
        
        if scoreManager.currentQuestion2 == dates.count {
            // Update totalAnswers if all questions are answered
            scoreManager.score2.totalAnswers = dates.count
            scoreManager.saveAnswers() // Save the number of total answers
            if scoreManager.mTotalScore2 > scoreManager.score2.totalScore {
                scoreManager.saveScore() // Save the score only if the current score is higher
            }
        }
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                // Back button
                HStack {
                    Button(action: {
                            showExitConfirmation = true
                            isInCarLightsView = false
                    }) {
                        Image(systemName: "arrow.left.circle.fill")
                            .resizable()
                            .frame(width: 50, height: 50)
                            .foregroundColor(.white)
                            .background(Circle().fill(Color.black.opacity(0.5)))
                    }
                    .padding(.leading, 0)
                    Spacer()
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.top, 10)
                
                if scoreManager.currentQuestion2 < dates.count {
                    let turn = dates[scoreManager.currentQuestion2]
                    
                    // Display image
                    Image(turn.imageName)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 300, height: 200)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        .padding(.top, 30)
                        .padding()
                    
                    // Display question
                    Text(turn.question)
                        .font(.title2)
                        .fontWeight(.regular)
                        .multilineTextAlignment(.center)
                        .foregroundColor(.black)
                        .padding()
                        .background(Color.green.opacity(0.5))
                        .cornerRadius(15)
                        .padding()
                        .padding(.horizontal, 20)
                    
                    // Display answer buttons
                    VStack(spacing: 2) {
                        ForEach(turn.answers.keys.sorted(), id: \.self) { answer in
                            Button(action: {
                                selectedAnswer = answer
                                checkAnswer(turn: turn)
                            }) {
                                HStack {
                                    Text("\(answer):")
                                        .font(.headline)
                                        .frame(width: 40)
                                        .foregroundColor(.black)
                                    
                                    Text(turn.answers[answer] ?? "")
                                        .font(.body)
                                        .foregroundColor(.black)
                                        Spacer()
                                }
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color.gray.opacity(0.2))
                                .cornerRadius(10)
                                .shadow(radius: 5)
                            }
                        }
                    }
                    
                    // Show feedback
                    if let errorMessage = errorMessage {
                        Text(errorMessage)
                            .font(.subheadline)
                            .foregroundColor(errorMessage == "Correct answer!" ? .green : .red)
                            .padding(.top, 20)
                    }
                    
                } else {
                    Text("You completed the quiz! Score: \(scoreManager.mTotalScore2)/\(dates.count)")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.green)
                        .padding(.top, 30)
                }
            }
            .padding()
            .padding(.horizontal, 20)
            .cornerRadius(20)
        }.transition(.opacity)
            .alert("Are you sure you want to exit?", isPresented: $showExitConfirmation) {
                    Button("Cancel", role: .cancel) { }
                    Button("Exit", role: .destructive) { isInCarLightsView = false
                        presentationMode.wrappedValue.dismiss()}
                }
    }
}

struct CarLightsView_Previews: PreviewProvider {
    static var previews: some View {
        CarLightsView(isInCarLightsView: .constant(true))
            .environmentObject(ErrorManager())
            .environmentObject(ScoreManager())
    }
}
