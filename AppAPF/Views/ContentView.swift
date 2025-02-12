import SwiftUI

struct ContentView: View {
    @StateObject var scoreManager = ScoreManager(score: QuizScore(quiz: "Quiz Incroci", totalScore: 8, totalAnswers: 10), currentScore: 0, quizManager: QuizManager())
    @StateObject var errorManager = ErrorManager()
    @StateObject var quizManager = QuizManager() // Aggiunto per evitare il crash
    @State private var selectedTab = 1
    @State private var isInLevelScene = false
    @State private var isInQuizView = false
    @State private var dragOffset: CGFloat = 0  // Per gestire il gesto di swipe

    var body: some View {
        ZStack {
            // Gestisci la navigazione tra le scene
            if isInLevelScene {
                LevelSceneView(isInLevelScene: $isInLevelScene)
                    .transition(.move(edge: .trailing))  // Transizione quando entri in LevelScene
            } else if isInQuizView {
                QuizView(isInQuizView: $isInQuizView)
                    .environmentObject(quizManager)  // Passa il QuizManager
                    .environmentObject(scoreManager) // Passa ScoreManager
                    .environmentObject(errorManager) // Passa ErrorManager
                    .transition(.move(edge: .trailing))  // Transizione quando entri in QuizView
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
                .transition(.opacity) // Animazione di dissolvenza tra le schermate
                .ignoresSafeArea()
                
                VStack {
                    if selectedTab == 1 { // Mostra il tasto solo quando siamo nella HomeScene
                        Button(action: {
                            withAnimation {
                                isInQuizView = true
                            }
                        }) {
                            Image("quizButton")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 200, height: 80)
                        }
                        .position(x: 100, y: 370)
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
        .gesture(
            DragGesture()
                .onChanged { value in
                    // Rileva il movimento orizzontale
                    if value.translation.width > 100 {
                        // Se l'utente ha fatto uno swipe verso destra (più di 100 punti)
                        withAnimation {
                            // Torna alla schermata precedente
                            if isInQuizView {
                                isInQuizView = false
                            } else if isInLevelScene {
                                isInLevelScene = false
                            }
                        }
                    }
                }
                .onEnded { value in
                    // Gestisci l'animazione finale se necessario
                    dragOffset = 0
                }
        )
        .animation(.default, value: isInLevelScene) // Applica l'animazione a tutto il cambiamento di stato
    }
}

#Preview {
    ContentView()
}
