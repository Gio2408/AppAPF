import SwiftUI

struct ContentView: View {
    @StateObject var scoreManager = ScoreManager(score: QuizScore(quiz: "Quiz Incroci", totalScore: 8, totalAnswers: 10), currentScore: 0, quizManager: QuizManager())
    @StateObject var errorManager = ErrorManager()
    @StateObject var quizManager = QuizManager() // Aggiunto per evitare il crash
    @State private var selectedTab = 1
    @State private var isInLevelScene = false
    @State private var isInQuizView = false
    @State private var isShowingPreHomeScene = true  // Stato per mostrare la schermata iniziale

    var body: some View {
        ZStack {
            if isShowingPreHomeScene {
                PreHomeSceneView()
                    .transition(.opacity) // Fade-in / Fade-out della PreHomeScene
            } else {
                if isInLevelScene {
                    LevelSceneView(isInLevelScene: $isInLevelScene)
                        .transition(.opacity) // Transizione fade
                } else if isInQuizView {
                    QuizView(isInQuizView: $isInQuizView)
                        .environmentObject(quizManager)
                        .environmentObject(scoreManager)
                        .environmentObject(errorManager)
                        .transition(.opacity)
                } else {
                    Group {
                        switch selectedTab {
                        case 0:
                            ScoreView()
                                .environmentObject(scoreManager)
                        case 1:
                            HomeSceneView(isInLevelScene: $isInLevelScene)
                        case 2:
                            ErrorsView().environmentObject(errorManager)
                        default:
                            HomeSceneView(isInLevelScene: $isInLevelScene)
                        }
                    }
                    .transition(.opacity) // Effetto dissolvenza quando si cambia tab
                    .ignoresSafeArea()
                    
                    VStack {
                        if selectedTab == 1 {
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
                        Spacer()
                        
                        VStack {
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
                                .animation(.easeInOut, value: selectedTab)
                                .transition(.scale)
                            }
                        }
                    }
                }
            }
        }
        .onAppear {
            // Nasconde la schermata iniziale dopo 2 secondi con animazione
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
