import SwiftUI
import SpriteKit

struct ContentView: View {

    @StateObject var scoreManager = ScoreManager(score: QuizScore(quiz: "Quiz Incroci", totalScore: 8, totalAnswers: 10), currentScore: 0, quizManager: QuizManager())
    @StateObject var errorManager = ErrorManager()
    @StateObject var quizManager = QuizManager() // Aggiunto per evitare il crash
    @State private var selectedTab = 1
    @State private var isInLevelScene = false
    @State private var isInQuizView = false

    var body: some View {
        ZStack {
            if isInLevelScene {
                LevelSceneView(isInLevelScene: $isInLevelScene)
            } else if isInQuizView {
                QuizView(isInQuizView: $isInQuizView)
                    .environmentObject(quizManager)  // Passa il QuizManager
                    .environmentObject(scoreManager) // Passa ScoreManager
                    .environmentObject(errorManager) // Passa ErrorManager
            } else {
                Group {
                    switch selectedTab {
                    case 0:
                        ScoreView()
                            .environmentObject(scoreManager)
                    case 1: HomeSceneView(isInLevelScene: $isInLevelScene)
                    case 2: ErrorsView().environmentObject(errorManager)
                    default: HomeSceneView(isInLevelScene: $isInLevelScene)
                    }
                }
                .transition(.opacity)
                .ignoresSafeArea()
                
                VStack {
                    if selectedTab == 1 { // Mostra il tasto solo quando siamo nella HomeScene
                            Button(action: {
                                isInQuizView = true
                            }) {
                                Image("quizButton")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 200, height: 80)
                            }
                            .padding(.top, 50)
                        }
                    Spacer()
                    
                    if !isInLevelScene {
                        HStack {
                            CustomTabButton(icon: "trophy.fill", tag: 0, selectedTab: $selectedTab)
                            CustomTabButton(icon: "house.fill", tag: 1, selectedTab: $selectedTab)
                            CustomTabButton(icon: "x.circle", tag: 2, selectedTab: $selectedTab)
                        }
                        .padding()
                        .background(.ultraThinMaterial)
                        .cornerRadius(20)
                        .padding(.horizontal, 20)
                        .shadow(radius: 5)
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
