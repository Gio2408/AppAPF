import SwiftUI
import SpriteKit

struct ContentView: View {

    @StateObject var scoreManager = ScoreManager(score: QuizScore(quiz: "Quiz Incroci", totalScore: 8, totalAnswers: 10), currentScore: 0, quizManager: QuizManager())
    @StateObject var errorManager = ErrorManager()
    @State private var selectedTab = 1
    @State private var isInLevelScene = false  // Controllo per LevelScene

    var body: some View {
        ZStack {
            if isInLevelScene {
                LevelSceneView(isInLevelScene: $isInLevelScene)  // Mostra LevelScene a tutto schermo
            } else {
                // Mostra la vista attuale in base alla selezione
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
                
                // Mostra la barra solo se NON siamo in LevelScene
                if !isInLevelScene {
                    VStack {
                        Spacer()
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
