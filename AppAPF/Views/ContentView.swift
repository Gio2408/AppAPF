import SwiftUI
import AVFoundation

struct ContentView: View {
    @StateObject var scoreManager = ScoreManager(score: QuizScore(quiz: "Quiz Incroci", totalScore: 8, totalAnswers: 10), currentScore: 0, quizManager: QuizManager())
    @StateObject var errorManager = ErrorManager()
    @StateObject var quizManager = QuizManager()
    
    @State private var isInLevelScene = false
    @State private var isInQuizView = false
    @State private var isShowingPreHomeScene = true
    @State private var isInErrorsView = false
    @State private var isInScoreView = false
    @State private var audioPlayer: AVAudioPlayer?
    
    var body: some View {
        ZStack {
            // Display PreHomeScene if necessary
            if isShowingPreHomeScene {
                PreHomeSceneView()
                    .transition(.opacity)
                    .onAppear {
                        playPreHomeSound() // Start the sound when PreHomeScene appears
                    }
            } else {
                // Switch between different views based on the state
                if isInLevelScene {
                    LevelSceneView(isInLevelScene: $isInLevelScene)
                } else if isInQuizView {
                    QuizView(isInQuizView: $isInQuizView)
                        .environmentObject(quizManager)
                        .environmentObject(scoreManager)
                        .environmentObject(errorManager)
                } else if isInErrorsView {
                    ErrorsView(isInErrorsView: $isInErrorsView)
                        .environmentObject(errorManager)
                } else if isInScoreView {
                    ScoreView(isInScoreView: $isInScoreView)
                        .environmentObject(scoreManager)
                } else {
                    HomeSceneView(isInLevelScene: $isInLevelScene)
                }
            }

            // Home Scene Buttons (Quiz, Errors, Score)
            if !isShowingPreHomeScene {
                VStack {
                    Spacer()
                    // Quiz Button to navigate to the quiz view
                    if !isInLevelScene {
                        Button(action: {
                            withAnimation(.easeIn(duration: 0.01)) { // Animazione più veloce
                                isInQuizView = true
                            }
                        }) {
                            Image("quizButton")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 100, height: 100)
                        }
                        .opacity(isInQuizView || isInScoreView || isInErrorsView ? 0 : 1)
                        .animation(.easeInOut(duration: 0.2), value: isInQuizView) // Applica l'animazione all'opacità
                        .position(x: 100, y: 370)
                    }
                }

                // Error and Score Buttons
                VStack(spacing: 10) {
                    Button(action: {
                        withAnimation { isInErrorsView = true }
                    }) {
                        Image(systemName: "x.circle")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 45, height: 45)
                            .foregroundColor(.yellow)
                    }

                    Button(action: {
                        withAnimation { isInScoreView = true }
                    }) {
                        Image(systemName: "trophy.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 45, height: 45)
                            .foregroundColor(.yellow)
                    }
                }
                .padding()
                .position(x: 40, y: UIScreen.main.bounds.height - 120)
                // Hide the buttons when in any other view
                .opacity(isInScoreView || isInErrorsView || isInQuizView || isInLevelScene ? 0 : 1)
            }
        }
        .onAppear {
            // Hide the PreHomeScene after 2 seconds
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                withAnimation { isShowingPreHomeScene = false }
            }
        }
    }
    
    // Function to play sound when the PreHomeScene is shown
    func playPreHomeSound() {
        guard let url = Bundle.main.url(forResource: "preHome", withExtension: "mp3") else {
            print("Error: Audio file not found")
            return
        }
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.play()
        } catch {
            print("Error playing audio: \(error.localizedDescription)")
        }
    }
}

#Preview {
    ContentView()
}
