import SwiftUI
import AVFoundation

struct ContentView: View {
    @StateObject var scoreManager = ScoreManager()
    @StateObject var errorManager = ErrorManager()
    
    @State private var isLevelComplete: Bool = false
    @State private var isLevel2Complete: Bool = false
    @State private var levelScene = 0
    @State private var isInQuizView = false
    @State private var isShowingPreHomeScene = true
    @State private var isInErrorsView = false
    @State private var isInScoreView = false
    @State private var dragOffset: CGFloat = 0  // To manage swipe gesture
    @State private var audioPlayer: AVAudioPlayer?
    @State private var path = NavigationPath() // NavigationPath for navigation

    var body: some View {
        NavigationStack(path: $path) { // Main NavigationStack
            ZStack {
                // Display PreHomeScene if necessary
                if isShowingPreHomeScene {
                    PreHomeSceneView()
                        .transition(.opacity)
                        .onAppear {
                            playPreHomeSound() // Start the sound when PreHomeScene appears
                        }
                } else {
                    if levelScene == 1{
                        LevelSceneView(levelScene: $levelScene, isLevelComplete: $isLevelComplete)
                            .transition(.opacity)
                    } else if levelScene == 2{
                        Level2SceneView(levelScene: $levelScene, isLevel2Complete: $isLevel2Complete)
                            .transition(.opacity)
                    } else if isInQuizView {
                        QuizView(isInQuizView: $isInQuizView)
                            .environmentObject(scoreManager)
                            .environmentObject(errorManager)
                            .transition(.opacity)
                    } else {
                        HomeSceneView(levelScene: $levelScene)
                            .transition(.opacity)
                    }
                }

                // Home Scene Buttons (Quiz, Errors, Score)
                if !isShowingPreHomeScene {
                    VStack {
                        Spacer()
                        VStack(spacing: 16) { // Place buttons in a column with space between them
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
                        // Hide buttons when in any other view
                        .opacity(isInScoreView || isInErrorsView || isInQuizView || levelScene > 0 ? 0 : 1)
                    }
                }
            }
            .navigationDestination(for: String.self) { destination in // Navigation destination management
                switch destination {
                case "errors":
                    ErrorsView()
                        .environmentObject(errorManager)
                case "score":
                    ScoreView()
                        .environmentObject(scoreManager)
                default:
                    EmptyView() // Handle other possible destinations
                }
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) { // modify the duration of the screen display
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
