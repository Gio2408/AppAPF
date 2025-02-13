import SwiftUI

struct ContentView: View {
    @StateObject var scoreManager = ScoreManager(score: QuizScore(quiz: "Quiz Incroci", totalScore: 8, totalAnswers: 10), currentScore: 0, quizManager: QuizManager())
    @StateObject var errorManager = ErrorManager()
    @StateObject var quizManager = QuizManager()
    @State private var isInLevelScene = false
    @State private var isInQuizView = false
    @State private var isShowingPreHomeScene = true
    @State private var isInErrorsView = false
    @State private var isInScoreView = false

    var body: some View {
        ZStack {
            if isShowingPreHomeScene {
                PreHomeSceneView()
                    .transition(.opacity)
            } else {
                if isInLevelScene {
                    LevelSceneView(isInLevelScene: $isInLevelScene)
                        .transition(.opacity)
                } else if isInQuizView {
                    QuizView(isInQuizView: $isInQuizView)
                        .environmentObject(quizManager)
                        .environmentObject(scoreManager)
                        .environmentObject(errorManager)
                        .transition(.opacity)
                } else if isInErrorsView {
                    ErrorsView(isInErrorsView: $isInErrorsView)
                        .environmentObject(errorManager)
                        .transition(.opacity)
                } else if isInScoreView {
                    ScoreView(isInScoreView: $isInScoreView)
                        .environmentObject(scoreManager)
                        .transition(.opacity)
                } else {
                    HomeSceneView(isInLevelScene: $isInLevelScene)
                        .transition(.opacity)
                }
            }

            // Pulsanti visibili solo dopo che la schermata iniziale è scomparsa
            if !isShowingPreHomeScene {
                VStack {
                    Spacer()

                    // Pulsante del quiz visibile solo nella HomeSceneView
                    if !isInLevelScene {
                        Button(action: {
                            withAnimation {
                                isInQuizView = true
                            }
                        }) {
                            Image("quizButton")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 100, height: 100)
                        }
                        .position(x: 100, y: 370)
                    }
                }
                // Pulsanti "Errori" e "Punteggi" con icone in basso a sinistra
                VStack(spacing: 10) {
                    Button(action: {
                        withAnimation {
                            isInErrorsView = true
                        }
                    }) {
                        Image(systemName: "x.circle")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 45, height: 45)
                            .foregroundColor(.white)
                    }

                    Button(action: {
                        withAnimation {
                            isInScoreView = true
                        }
                    }) {
                        Image(systemName: "trophy.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 45, height: 45)
                            .foregroundColor(.white)
                    }
                }
                .padding()
                .position(x: 40, y: UIScreen.main.bounds.height - 120) // Posizione in basso a sinistra
                .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                withAnimation {
                    isShowingPreHomeScene = false
                }
            }
        }
    }
}


#Preview {
    ContentView()
}
