import SwiftUI
import SpriteKit
import AVFoundation

struct LevelSceneView: View {
    @Binding var levelScene: Int // State to return to HomeView
    @Binding var isLevelComplete: Bool  // State to monitor level completion
    @State private var showExitConfirmation = false // State to show the popup
    @State private var audioPlayer: AVAudioPlayer? // For audio management
    
    var scene: SKScene? {
        guard let scene = SKScene(fileNamed: "LevelScene") else {
            print("⚠️ Error: Unable to load LevelScene.sks")
            return nil
        }
        scene.size = CGSize(width: 1170, height: 2532)
        scene.scaleMode = .aspectFill
        
        if let levelScene = scene as? LevelScene {
            levelScene.levelCompleteCallback = {
                self.isLevelComplete = true
            }
        }
        
        return scene
    }

    var body: some View {
        ZStack {
            if let scene = scene {
                SpriteView(scene: scene)
                    .ignoresSafeArea()
            } else {
                Text("Error loading the scene")
                    .foregroundColor(.red)
            }

            VStack {
                HStack {
                    Button(action: {
                        showExitConfirmation = true // Show the confirmation popup
                    }) {
                        Image(systemName: "arrow.left.circle.fill")
                            .resizable()
                            .frame(width: 50, height: 50)
                            .foregroundColor(.white)
                            .background(Circle().fill(Color.black.opacity(0.5)))
                    }
                    .padding(.leading, 20)
                    Spacer()
                }
                Spacer()

                if isLevelComplete {
                    Button(action: {
                        levelScene = 2
                        isLevelComplete = false
                    }) {
                        Text("Continue")
                            .font(.title)
                            .fontWeight(.heavy)
                            .foregroundColor(.white)
                            .padding(.horizontal, 40)
                            .padding(.vertical, 15)
                            .background(Color.green.opacity(0.7))
                            .clipShape(Capsule())
                            .shadow(color: Color.black.opacity(0.6), radius: 10)
                    }
                    .padding()
                }

            }
        }
        .transition(.opacity)
        .alert("Are you sure you want to exit?", isPresented: $showExitConfirmation) {
            Button("Cancel", role: .cancel) { }
            Button("Exit", role: .destructive) {
                stopSound() // Stop the sound when exiting the scene
                levelScene = 0 // Return to HomeView
                isLevelComplete = false
            }
        }
        .onAppear {
            playSound() // Start the sound when entering LevelScene
        }
        .onDisappear {
            stopSound() // Stop the sound when exiting LevelScene
        }
    }

    // Function to play the sound
    func playSound() {
        guard let url = Bundle.main.url(forResource: "car-engine", withExtension: "mp3") else {
            print("Error: Audio file not found")
            return
        }
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.play()
        } catch {
            print("Error playing sound: \(error.localizedDescription)")
        }
    }

    // Function to stop the sound
    func stopSound() {
        audioPlayer?.stop()
        audioPlayer = nil
    }
}

struct LevelSceneView_Previews: PreviewProvider {
    static var previews: some View {
        LevelSceneView(levelScene: .constant(1), isLevelComplete: .constant(false))
    }
}
