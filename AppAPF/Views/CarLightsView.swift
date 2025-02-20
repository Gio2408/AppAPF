import SwiftUI

struct CarLightsView: View {
    @Binding var isInCarLightsView: Bool
    @Environment(\.presentationMode) var presentationMode

    @EnvironmentObject var errorManager: ErrorManager
    @EnvironmentObject var scoreManager: ScoreManager
    @State private var selectedAnswer: String?
    @State private var errorMessage: String?
    @State private var showExitConfirmation2: Bool = false

    struct Data {
        let question: String
        let correctAnswer: String
        let imageName: String
        let answers: [String: String]
    }

    let dates = [
        Data(
            question: "What to do when you see a red light?",
            correctAnswer: "Stop in a safe place and check the problem",
            imageName: "carLights1",
            answers: [
                "A": "Ignore it and hope it goes out by itself",
                "B": "Check the car manual",
                "C": "Stop in a safe place and check the problem",
                "D": "Turn on the radio to avoid hearing about it"
            ]
        ),
        Data(
            question: "(Anti-lock Braking System) ABS light on: What to do?",
            correctAnswer: "Check if the braking system is working correctly",
            imageName: "carLights2",
            answers: [
                "A": "Continue driving without worry",
                "B": "Stop immediately and call a tow truck",
                "C": "Check if the braking system is working correctly",
                "D": "Change the brake pads"
            ]
        ),
        Data(
            question: "What color warning light signals a critical issue?",
            correctAnswer: "Red",
            imageName: "carLights3",
            answers: [
                "A": "Green",
                "B": "Blue",
                "C": "Yellow",
                "D": "Red"
            ]
        ),
        Data(
            question: "Engine temp light red: What NOT to do?",
            correctAnswer: "Continue driving as if nothing is wrong",
            imageName: "carLights4",
            answers: [
                "A": "Continue driving as if nothing is wrong",
                "B": "Stop in a safe place and let the engine cool down",
                "C": "Check the coolant level",
                "D": "Call a mechanic if the problem persists"
            ]
        ),
        Data(
            question: "Color of low beam headlight indicator?",
            correctAnswer: "Green",
            imageName: "carLights5",
            answers: [
                "A": "Blue",
                "B": "Green",
                "C": "Yellow",
                "D": "Red"
            ]
        ),
        Data(
            question: "Which warning light indicates brake light problem?",
            correctAnswer: "Yellow bulb - exclamation light",
            imageName: "carLights6",
            answers: [
                "A": "Red circle light with (!)",
                "B": "Yellow bulb - exclamation light",
                "C": "A blue light with a light bulb",
                "D": "None, the car does not warn about this issue"
            ]
        ),
        Data(
            question: "Handbrake engaged: Which light stays on?",
            correctAnswer: "A red light with a 'P' inside a circle",
            imageName: "carLights7",
            answers: [
                "A": "A red light with a 'P' inside a circle",
                "B": "A yellow light with an exclamation point",
                "C": "A green light with a brake symbol",
                "D": "No light, the handbrake automatically disengages"
            ]
        ),
        Data(
            question: "Red circle with exclamation point: Meaning?",
            correctAnswer: "A problem with the brakes or brake fluid",
            imageName: "carLights8",
            answers: [
                "A": "A problem with the brakes or brake fluid",
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
                "B": "Someone in the car hasn’t fastened their seatbelt",
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
                "D": "Red"
            ]
        )
    ]

    func checkAnswer(turn: Data) {
        if scoreManager.currentQuestion == 0 {
            scoreManager.resetWarningScore()
            errorManager.deleteWarningErrors()
        }

        if selectedAnswer != turn.correctAnswer {
            let errorLights = QuizError(question: turn.question, correctAnswer: turn.correctAnswer, userAnswer: selectedAnswer ?? "N/A")
            errorManager.addWarningError(errorLights)
            errorMessage = "Wrong answer!"
        } else {
            errorMessage = "Correct answer!"
            scoreManager.incrementWarningScore()
        }

        scoreManager.incrementQuestion()

        if scoreManager.currentQuestion == dates.count {
            scoreManager.WarningScore.totalAnswers = dates.count
            scoreManager.saveWarningAnswers()
            if scoreManager.mWarningTotalScore > scoreManager.WarningScore.totalScore {
                scoreManager.saveWarningScore()
            }
        }
    }

    var body: some View {
        ZStack(alignment: .topLeading) {
            Image("road2")
                .resizable()
                .scaledToFit()
                .edgesIgnoringSafeArea(.all)
                .blur(radius: 8)

            VStack {
                if scoreManager.currentQuestion < dates.count {
                    let turn = dates[scoreManager.currentQuestion]
                    Spacer()

                    Image(turn.imageName)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 200, height: 200)
                        .clipShape(RoundedRectangle(cornerRadius: 20))

                    Text(turn.question)
                        .font(.title2)
                        .fixedSize(horizontal: false, vertical: true)
                        .fontWeight(.medium)
                        .multilineTextAlignment(.center)
                        .foregroundColor(.black)
                        .padding()
                        .background(Color.green.opacity(0.7))
                        .cornerRadius(15)
                        .padding()

                    VStack(spacing: 2) {
                        ForEach(turn.answers.values.sorted(), id: \.self) { answer in
                            Button(action: {
                                withAnimation(.smooth(duration: 0.1)) { // Customize animation
                                    selectedAnswer = answer
                                    checkAnswer(turn: turn)
                                }
                            }) {
                                HStack {
                                    Text("\(answer)")
                                        .font(.headline)
                                        .fontWeight(.medium)
                                        .foregroundColor(.black)
                                        .frame(maxWidth: .infinity, alignment: .center)

                                    Text(turn.answers[answer] ?? "")
                                        .font(.body)
                                        .fontWeight(.heavy)
                                        .fixedSize(horizontal: false, vertical: true)
                                        .foregroundColor(.black)
                                    Spacer()
                                }
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color.white.opacity(0.4)) // Button background color
                                .cornerRadius(10)
                            }
                        }
                    }

                    if let errorMessage = errorMessage {
                        Text(errorMessage)
                            .padding(.top, 10)
                            .font(.subheadline)
                            .fontWeight(.bold)
                            .foregroundColor(Color.black)
                    }

                } else {
                    Text("You completed the quiz! Score: \(scoreManager.mWarningTotalScore)/\(dates.count)")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.black) // Completed message color
                        .padding(.top, 300) // Padding for completed message
                        .onAppear {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2) { // 2-second delay
                                isInCarLightsView = false
                                presentationMode.wrappedValue.dismiss()
                                
                            }
                        }
                }
            }
            .padding()
            .padding(.horizontal, 20)
            .cornerRadius(20)

            Button(action: {
                isInCarLightsView = false
                showExitConfirmation2 = true
            }) {
                Image(systemName: "arrow.left.circle.fill")
                    .resizable()
                    .frame(width: 50, height: 50)
                    .foregroundColor(.white)
                    .background(Circle().fill(Color.black.opacity(0.5)))
            }
            .padding(.leading, 20)
            .padding(.top, 10)
            .frame(maxWidth: .infinity, alignment: .topLeading)

        }.transition(.opacity)
            .alert("Are you sure you want to exit?", isPresented: $showExitConfirmation2) {
                Button("Cancel", role: .cancel) { }
                Button("Exit", role: .destructive) {
                    isInCarLightsView = false
                    presentationMode.wrappedValue.dismiss()
                }
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
