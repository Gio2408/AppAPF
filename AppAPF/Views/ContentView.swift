import SwiftUI
import SpriteKit

struct ContentView: View {
    @StateObject var errorManager = ErrorManager()
    @State private var selectedTab = 0
    @State private var isInLevelScene = false  // Controllo per LevelScene

    var body: some View {
        ZStack {
            if isInLevelScene {
                LevelSceneView(isInLevelScene: $isInLevelScene)  // Mostra LevelScene a tutto schermo
            } else {
                // Mostra la vista attuale in base alla selezione
                Group {
                    switch selectedTab {
                    case 0: HomeSceneView(isInLevelScene: $isInLevelScene)
                    case 1: ErrorsView().environmentObject(errorManager)
                   // case 2: ScoreView()
                    //        .environmentObject(ScoreManager())
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
                            CustomTabButton(icon: "flame.fill", tag: 2, selectedTab: $selectedTab)
                            CustomTabButton(icon: "house.fill", tag: 0, selectedTab: $selectedTab)
                            CustomTabButton(icon: "x.circle", tag: 1, selectedTab: $selectedTab)
                            
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
