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
            if isShowingPreHomeScene {
                PreHomeSceneView()
                    .transition(.opacity)
                    .onAppear {
                        playPreHomeSound() // Avvia il suono all'apertura della PreHomeScene
                    }
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

            if !isShowingPreHomeScene {
                VStack {
                    Spacer()

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
                        .opacity(isInQuizView ? 0 : 1)
                        .opacity(isInScoreView ? 0 : 1)
                        .opacity(isInErrorsView ? 0 : 1)
                        .position(x: 100, y: 370)
                    }
                }

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
                            .foregroundColor(.yellow)
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
                            .foregroundColor(.yellow)
                    }
                }
                .padding()
                .position(x: 40, y: UIScreen.main.bounds.height - 120)
                .frame(maxWidth: .infinity, alignment: .leading)
                .opacity((isInScoreView || isInErrorsView || isInQuizView
                         || isInLevelScene) ? 0 : 1)
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
    
    // Funzione per avviare il suono
    func playPreHomeSound() {
        guard let url = Bundle.main.url(forResource: "preHome", withExtension: "mp3") else {
            print("Errore: File audio non trovato")
            return
        }
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.play()
        } catch {
            print("Errore nella riproduzione audio: \(error.localizedDescription)")
        }
    }
}

#Preview {
    ContentView()
}
