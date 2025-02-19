import SwiftUI
import SpriteKit
import AVFoundation

struct Level2SceneView: View {
    @Binding var levelScene: Int // State to return to HomeView
    @Binding var isLevel2Complete: Bool  // State to monitor level completion
    @State private var showExitConfirmation = false // State to show the popup
    @State private var audioPlayer: AVAudioPlayer? // For audio management
    
    var scene: SKScene? {
        guard let scene = SKScene(fileNamed: "Level2Scene") else {
            print("⚠️ Error: Unable to load LevelScene.sks")
            return nil
        }
        scene.size = CGSize(width: 1170, height: 2532)
        scene.scaleMode = .aspectFill
        
        // Ensure the callback is passed to notify level completion
        if let level2Scene = scene as? Level2Scene {
            level2Scene.level2CompleteCallback = {
                self.isLevel2Complete = true
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

                // Show the "Continue" button if the level is complete
                if isLevel2Complete {
                    Button(action: {
                        levelScene = 0  // Return to ContentView
                        isLevel2Complete = false
                    }) {
                        Text("Well done!")
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
                isLevel2Complete = false
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

struct Level2SceneView_Previews: PreviewProvider {
    static var previews: some View {
        Level2SceneView(levelScene: .constant(1), isLevel2Complete: .constant(true))
    }
}
