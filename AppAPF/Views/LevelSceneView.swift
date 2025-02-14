import SwiftUI
import SpriteKit

struct LevelSceneView: View {
    @Binding var isInLevelScene: Bool  // State for returning to ContentView

    var scene: SKScene? {
        // Attempt to load the LevelScene from a file
        guard let scene = SKScene(fileNamed: "LevelScene") else {
            print("⚠️ Error: Unable to load LevelScene.sks")  // Error message if loading fails
            return nil
        }
        scene.size = CGSize(width: 1170, height: 2532)  // Set the size of the scene
        scene.scaleMode = .aspectFill  // Set the scale mode for the scene
        return scene
    }

    var body: some View {
        ZStack {
            // If the scene is successfully loaded, display it
            if let scene = scene {
                SpriteView(scene: scene)  // Display the SpriteKit scene
                    .ignoresSafeArea()  // Make the scene fill the entire screen
            } else {
                // Display an error message if the scene could not be loaded
                Text("Error loading the scene")
                    .foregroundColor(.red)
            }

            VStack {
                HStack {
                    Button(action: {
                        withAnimation(.easeInOut(duration: 0.5)) {
                            isInLevelScene = false  // Transition back to ContentView with fade animation
                        }
                    }) {
                        Image(systemName: "arrow.left.circle.fill")  // Left arrow button for navigation
                            .resizable()
                            .frame(width: 50, height: 50)
                            .foregroundColor(.white)
                            .background(Circle().fill(Color.black.opacity(0.5)))  // Dark background for the button
                    }
                    .padding(.leading, 20)

                    Spacer()  // Space between the button and the rest of the screen
                }
                Spacer()  // Add some space at the bottom of the screen
            }
        }
        .transition(.opacity)  // Apply fade-in and fade-out transition
    }
}

struct LevelSceneView_Previews: PreviewProvider {
    static var previews: some View {
        LevelSceneView(isInLevelScene: .constant(true))
    }
}
