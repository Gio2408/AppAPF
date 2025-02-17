import SwiftUI
import AVFoundation

struct ContentView: View {
    @StateObject var scoreManager = ScoreManager()
    @StateObject var errorManager = ErrorManager()
    @State private var isInLevelScene = false
    @State private var isInQuizView = false
    @State private var isShowingPreHomeScene = true
    @State private var isInErrorsView = false
    @State private var isInScoreView = false
    @State private var dragOffset: CGFloat = 0  // Per gestire il gesto di swipe
    @State private var audioPlayer: AVAudioPlayer?
    @State private var path = NavigationPath() // NavigationPath per la navigazione

    var body: some View {
        NavigationStack(path: $path) { // NavigationStack principale
            ZStack {
                // Display PreHomeScene if necessary
                if isShowingPreHomeScene {
                    PreHomeSceneView()
                        .transition(.opacity)
                        .onAppear {
                            playPreHomeSound() // Start the sound when PreHomeScene appears
                        }
                } else {
                    if isInLevelScene {
                        LevelSceneView(isInLevelScene: $isInLevelScene)
                            .transition(.opacity)
                    } else if isInQuizView {
                        QuizView(isInQuizView: $isInQuizView)
                            .environmentObject(scoreManager)
                            .environmentObject(errorManager)
                            .transition(.opacity)
                    } else {
                        HomeSceneView(isInLevelScene: $isInLevelScene)
                            .transition(.opacity)
                    }
                }
                
                
                // Home Scene Buttons (Quiz, Errors, Score)
                if !isShowingPreHomeScene {
                    VStack {
                        Spacer()
                        VStack(spacing: 16) { // Mettiamo i pulsanti in colonna con spazio tra loro
                            Button(action: {
                                path.append("errors")
                            }) {
                                Image(systemName: "x.circle")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 45, height: 45)
                                    .foregroundColor(.white)
                                
                            }
                            Button(action: {
                                path.append("score")
                            }) {
                                Image(systemName: "trophy.fill")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 45, height: 45)
                                    .foregroundColor(.white)
                            }
                        }
                        .padding()
                        .position(x: 40, y: UIScreen.main.bounds.height - 130)
                        // Hide the buttons when in any other view
                        .opacity(isInScoreView || isInErrorsView || isInQuizView || isInLevelScene ? 0 : 1)
                    }
                }
            }
            .navigationDestination(for: String.self) { destination in // Gestione delle destinazioni
                switch destination {
                case "errors":
                    ErrorsView()
                        .environmentObject(errorManager)
                case "score":
                    ScoreView()
                        .environmentObject(scoreManager)
                default:
                    EmptyView() // Gestisci eventuali altre destinazioni
                }
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) { // modifica tempo di permanenza della schermata
                    withAnimation {
                        isShowingPreHomeScene = false
                    }
                }
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
